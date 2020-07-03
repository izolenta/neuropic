library neuropic.state.game_state;

import 'dart:html';

import 'package:built_value/built_value.dart';
import 'package:perceptron/perceptron.dart';

part 'game_state.g.dart';

abstract class GameState implements Built<GameState, GameStateBuilder> {
  factory GameState([void Function(GameStateBuilder b) updates]) = _$GameState;

  GameState._();

  ImageElement get image;

  int get imagePartX;

  int get imagePartY;

  @nullable
  double get angle;

  List<TrainingData> get trainingData;
}