import 'dart:math';

@TestOn('vm')
import 'package:neuropic/src/utils/helper.dart';
import 'package:test/test.dart';

void main() {
  setUp(() async {
  });

  test('convert angle to input and back', () {
    final angles = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170];
    angles.forEach((angle) {
      final output = convertAngleToOutput(angle.toDouble());
      final back = convertOutputToAngle(output);
      expect((angle-back).abs(), lessThan(0.00000001));
    });
  });

  test('array rotation 90 degrees', () {
    final rand = Random();
    final arr = <double>[];
    for (var i=0; i<49; i++) {
      arr.add(rand.nextDouble());
    }
    final rotated = turn90input(arr);
    for (var i=0; i<7; i++) {
      for (var j=0; j<7; j++) {
        expect(arr[i*7+j], equals(rotated[j*7 + (6-i)]));
      }
    }
  });

  test('array rotation 180 degrees', () {
    final rand = Random();
    final arr = <double>[];
    for (var i=0; i<49; i++) {
      arr.add(rand.nextDouble());
    }
    final rotated = turn180input(arr);
    for (var i=0; i<7; i++) {
      for (var j=0; j<7; j++) {
        expect(arr[i*7+j], equals(rotated[(6-i)*7 + (6-j)]));
      }
    }
  });

  test('output rotation 90 degrees', () {
    final angles = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170];
    final results = [90, 100, 110, 120, 130, 140, 150, 160, 170, 0, 10, 20, 30, 40, 50, 60, 70, 80];
    var bit = 1;
    for (var i=0; i<angles.length; i++) {
      final output = convertAngleToOutput(angles[i].toDouble())..add(bit.toDouble());
      final output2 = convertAngleToOutput(results[i].toDouble())..add(bit.toDouble());
      final result = turn90output(output);
      for (var j=0; j<4; j++) {
        expect(result[j], equals(output2[j]));
      }
    }
  });

  test('output mirroring vertical', () {
    final angles = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170];
    final results = [0, 170, 160, 150, 140, 130, 120, 110, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10];
    var bit = 1;
    for (var i=0; i<angles.length; i++) {
      final output = convertAngleToOutput(angles[i].toDouble())..add(bit.toDouble());
      final output2 = convertAngleToOutput(results[i].toDouble())..add(bit.toDouble());
      final result = mirrorOutput(output);
      for (var j=0; j<4; j++) {
        expect(result[j], equals(output2[j]));
      }
    }
  });

}
