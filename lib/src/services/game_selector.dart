import 'dart:html';

import 'package:neuropic/src/state/game_state.dart';

class GameSelector {

  CanvasElement _canvas;


  List<double> getSquare(GameState state) {
    if (_canvas == null && state.image.width != 0) {
      _canvas = document.createElement('canvas') as CanvasElement;
      _canvas.width = state.image.width;
      _canvas.height = state.image.height;
      _canvas.context2D.drawImage(state.image, 0, 0);
    }
    if (_canvas == null) {
      return null;
    }
    final context = _canvas.context2D;
    final res = <double>[];
    for (var i=0; i<7; i++) {
      for (var j=0; j<7; j++) {
        final data = context.getImageData(state.imagePartX + j, state.imagePartY + i, 1, 1);
        res.add(data.data[0].toDouble());
      }
    }
    return res;
  }
}
