List<double> convertAngleToOutput(double angle) {
  assert(angle >=0 && angle <180);
  if (angle <= 60) {
    return[1-angle/60, angle/60, 0];
  }
  if (angle <= 120) {
    return[0, 2-angle/60, angle/60-1];
  }
  else {
    return[angle/60-2, 0, 3-angle/60];
  }
}

double convertOutputToAngle(List<double> input) {
  assert(input.length == 3);
  if (input[2] == 0) {
    return (1 - input[0]) * 60;
  }
  if (input[0] == 0) {
    return (2 - input[1]) * 60;
  }
  if (input[1] == 0) {
    return (3 - input[2]) * 60;
  }
  throw ArgumentError('Wrong input');
}

List<double> inverse(List<double> input) {
  final res = <double>[];
  for (var next in input) {
    res.add(1-next);
  }
  return res;
}

List<double> mirrorVerticalInput(List<double> input) {
  final rotated = input.toList();
  for (var i = 0; i < 7; i++) {
    for (var j = 0; j < 7; j++) {
      rotated[i*7+j] = input[i*7+(6-j)];
    }
  }
  return rotated;
}

List<double> mirrorHorizontalInput(List<double> input) {
  final rotated = input.toList();
  for (var i = 0; i < 7; i++) {
    for (var j = 0; j < 7; j++) {
      rotated[i*7+j] = input[(6-i)*7+j];
    }
  }
  return rotated;
}

List<double> mirrorOutput(List<double> input) {
  final data = input.getRange(0, 3).toList();
  final point = input[3];
  final angle = (180-convertOutputToAngle(data)) % 180;
  return convertAngleToOutput(angle)..add(point);
}

List<double> turn90input(List<double> input) {
  final rotated = input.toList();
  for (var i = 0; i < 7; i++) {
    for (var j = 0; j < 7; j++) {
      rotated[j*7+i] = input[(6-i)*7+j];
    }
  }
  return rotated;
}

List<double> turn90output(List<double> input) {
  final data = input.getRange(0, 3).toList();
  final point = input[3];
  final angle = (convertOutputToAngle(data) + 90) % 180;
  return convertAngleToOutput(angle)..add(point);
}

List<double> turn180input(List<double> input) {
  var res = turn90input(input);
  return turn90input(res);
}

List<double> turn180output(List<double> input) {
  var res = turn90output(input);
  return turn90output(res);
}

List<double> turn270input(List<double> input) {
  var res = turn90input(input);
  res = turn90input(res);
  return turn90input(res);
}

List<double> turn270output(List<double> input) {
  var res = turn90output(input);
  res = turn90output(res);
  return turn90output(res);
}
