import 'dart:convert';
import 'dart:io';

import 'package:neuropic/src/utils/helper.dart';
import 'package:perceptron/perceptron.dart';

void main(List args) async {
  final jsonData = File('traindata').readAsStringSync();
  final trainData = jsonDecode(jsonData) as List<dynamic>;
  final result = <TrainingData>[];
  for(var data in trainData) {
    final map = jsonDecode(data) as Map;
    final baseInput = (map['i'] as List).map((n) => double.parse(n.toString())).toList(); //don't ask me why
    final baseOutput = (map['o'] as List).map((n) => double.parse(n.toString())).toList();
    for (var k=0; k<3; k++) {
      var inputArray = baseInput;
      var outputArray = baseOutput;
      switch(k) {
        case 0:
          inputArray = baseInput;
          outputArray = baseOutput;
          break;
        case 1:
          inputArray = mirrorVerticalInput(baseInput);
          outputArray = mirrorOutput(baseOutput);
          break;
        case 2:
          inputArray = mirrorHorizontalInput(baseInput);
          outputArray = mirrorOutput(baseOutput);
          break;
      }
      result.add(TrainingData(inputArray, outputArray));
      result.add(TrainingData(inverse(inputArray), outputArray));
      result.add(TrainingData(scale(inputArray, 2), outputArray));
      result.add(TrainingData(inverse(scale(inputArray, 2)), outputArray));
      result.add(TrainingData(scale(inputArray, 4), outputArray));
      result.add(TrainingData(inverse(scale(inputArray, 4)), outputArray));

      var input2 = inputArray;
      var output2 = outputArray;
      for (var i = 0; i < 3; i++) {
        input2 = turn90input(input2);
        output2 = turn90output(output2);
        result.add(TrainingData(input2, output2));
        result.add(TrainingData(inverse(input2), output2));
        result.add(TrainingData(scale(input2, 2), output2));
        result.add(TrainingData(inverse(scale(input2, 2)), output2));
        result.add(TrainingData(scale(input2, 4), output2));
        result.add(TrainingData(inverse(scale(input2, 4)), output2));
      }
    }
  }
  print(result.length);
  final perceptron = Perceptron([49, 30, 4], 1);
  perceptron.trainForPic(result);
  print(perceptron.toJson());
}



