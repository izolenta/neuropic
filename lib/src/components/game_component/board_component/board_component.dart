import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:neuropic/src/actions/get_next_square_action.dart';
import 'package:neuropic/src/actions/store_training_data_action.dart';
import 'package:neuropic/src/services/game_dispatcher.dart';
import 'package:neuropic/src/services/game_selector.dart';
import 'package:neuropic/src/services/game_service.dart';
import 'package:neuropic/src/state/game_state.dart';
import 'package:neuropic/src/utils/helper.dart';

@Component(
  selector: 'board',
  styleUrls: ['board_component.css'],
  templateUrl: 'board_component.html',
  directives: [NgFor],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class BoardComponent implements AfterChanges {

  @Input()
  GameState state;

  @ViewChild('board')
  CanvasElement canvas;

  final GameSelector _selector;
  final GameService _service;
  final GameDispatcher _dispatcher;
  
  Point startPoint;
  Point endPoint;

  BoardComponent(this._selector, this._dispatcher, this._service);

  @override
  void ngAfterChanges() {
    _redraw(lazy: false);
  }

  void _redraw({bool lazy = true}) {
    final context = canvas.context2D;
    context.setFillColorRgb(255, 255, 255);
    context.fillRect(0, 0, 450, 450);
    final data = _selector.getSquare(state);
    if (data != null) {
      for (var i = 0; i < 7; i++) {
        for (var j = 0; j < 7; j++) {
          final index = (6-i) * 7 + j;
          context.setFillColorRgb(data[index].toInt(), data[index].toInt(), data[index].toInt());
          context.fillRect(100 + j * 30, 100 + i * 30, 29, 29);
        }
      }
    }
    if (startPoint != null && endPoint != null) {
      context.setFillColorRgb(0, 0, 0);
      context.lineWidth = 3;
      context.beginPath();
      context.moveTo(startPoint.x, startPoint.y);
      context.lineTo(endPoint.x, endPoint.y);
      context.stroke();
    }
    if (!lazy && data != null) {
//      final angle = _service.getAngle(data);
//      print('angle: $angle');
      final foundAngle = _selector.getAngle(state);
      print(foundAngle);
      if (foundAngle != null) {
        final na = 180 - foundAngle;
        var strokeLen = 16;
        final centerX = 20;
        final centerY = 20;
        final startX = centerX + strokeLen * cos(na * pi / 180);
        final startY = centerY + strokeLen * sin(na * pi / 180);
        final endX = centerX + strokeLen * cos(na * pi / 180+ pi);
        final endY = centerY + strokeLen * sin(na * pi / 180 + pi);
        context.beginPath();
        context.lineWidth = 1;
        context.setFillColorRgb(0, 0, 0);
        context.moveTo(startX, startY);
        context.lineTo(endX, endY);
        context.stroke();
      }
    }
  }
  
  void onMouseDown(MouseEvent evt) {
    evt.stopPropagation();
    if (evt.button == 0) {
      startPoint = evt.offset;
    }
  }

  void onMouseMove(MouseEvent evt) {
    evt.stopPropagation();
    if (startPoint != null) {
      endPoint = evt.offset;
      _redraw();
    }
  }

  void onMouseUp(MouseEvent evt) {
    evt.stopPropagation();
    if (evt.button == 1) {
      print('skip');
      _dispatcher.dispatch(GetNextSquareAction());
    }
    else if (startPoint != null && endPoint != null) {
      int dx = endPoint.x - startPoint.x;
      int dy = endPoint.y - startPoint.y;
      var angle;
      if (dx == 0) {
        angle = dy.sign * pi / 2;
      }
      else {
        angle = atan(dy/dx);
      }
      while (angle < 0) {
        angle += pi;
      }
      while (angle >= pi) {
        angle -= pi;
      }
      angle = 180 - angle / pi * 180;
      print('drawn angle: $angle');
      _dispatcher.dispatch(StoreTrainingDataAction(convertAngleToOutput(angle)..add(1.0)));
    }
    else {
      _dispatcher.dispatch(StoreTrainingDataAction([0.0, 0.0, 0.0, 0.0]));
    }
    startPoint = null;
    endPoint = null;
  }
}
