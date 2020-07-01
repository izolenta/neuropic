import 'dart:html';

import 'package:neuropic/src/state/game_state.dart';

class GameStateFactory {
  GameState getInitialState() =>
      GameState((c) => c
          ..image = ImageElement()
          ..imagePartX = 0
          ..imagePartY = 0
          ..trainingData = []
      );
}