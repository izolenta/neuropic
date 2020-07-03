import 'dart:io';
import 'dart:math';

import 'package:image/image.dart';
import 'package:neuropic/src/utils/helper.dart';
import 'package:perceptron/perceptron.dart';

final rand = Random();

void main(List args) async {
  final perceptron = Perceptron.fromJson(File('neuro_1').readAsStringSync());
  assert(args.length == 5);
  final step = int.parse(args[4]);
  final bytes = File(args[0]).readAsBytesSync();
  final image = decodeImage(bytes);
  final width = image.width;
  final height = image.height;
  final widthRes = width ~/7 * 7 - 7;
  final heightRes = height ~/7 * 7 - 7;
  var imgres = Image(widthRes, heightRes);
  imgres = fillRect(imgres, 0, 0, widthRes, heightRes, 0xFFFFFFFF);
  for (var i=0; i<heightRes-step; i+=step) {
    for (var j=0; j<widthRes-step; j+=step) {
      final input = <double>[];
      for (var y=0; y<7; y++) {
        for (var x=0; x<7; x++) {
          input.add((image.getPixel(j+x, i+y)%256)/256);
        }
      }
      final result = perceptron.process(input);
      var angle = getAngle(result);
      var lumi = 1 - (input.reduce((a, b) => a + b) / 49);
      var color = 0xFF000000;
      if (angle == null) {
        if (lumi > 0.05 && int.parse(args[3]) == 1) {
          angle = 60;//rand.nextDouble() * 180;
          var byte = (255 - lumi*255).toInt();
          color += (byte * 65536 + byte * 256 + byte);
        }
        else {
          continue;
        }
      }
      else {
//        angle = 180 - angle;
        if (result[3] > 0.15) {
          lumi = 1;
        }
        else {
          lumi = result[3];
        }
      }
      final strokeLen = lumi * int.parse(args[2]);
      final centerX = j+3;
      final centerY = i+3;
      final startX = centerX + strokeLen * cos(angle * pi / 180);
      final startY = centerY + strokeLen * sin(angle * pi / 180);
      final endX = centerX + strokeLen * cos(angle * pi / 180 + pi);
      final endY = centerY + strokeLen * sin(angle * pi / 180 + pi);
      imgres = drawLine(imgres, startX.toInt(), startY.toInt(), endX.toInt(), endY.toInt(), color);
    }
    print('y = $i');
  }
  File(args[1]).writeAsBytesSync(encodePng(imgres));
}

double getAngle(List<double> input) {
  if (input[3] < 0.5) {
    return null;
  }
  final ranged = input.getRange(0, 3).toList();
  final minimum = ranged.reduce(min);
  for (var i=0; i<3; i++) {
    if (ranged[i] == minimum) {
      ranged[i] = 0;
      break;
    }
  }
  var sum = 0.0;
  ranged.forEach((n) => sum+=n);
  for (var i=0; i<3; i++) {
    if (ranged[i] != 0) {
      ranged[i] = ranged[i]/sum;
    }
  }
//  print(ranged);
  return convertOutputToAngle(ranged.toList());
}