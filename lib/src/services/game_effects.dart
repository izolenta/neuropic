import 'dart:async';
import 'dart:html';

import 'package:neuropic/src/actions/calculate_angle_success_action.dart';
import 'package:neuropic/src/actions/get_next_square_action.dart';
import 'package:neuropic/src/actions/init_tool_action.dart';
import 'package:neuropic/src/actions/init_tool_success_action.dart';
import 'package:neuropic/src/actions/store_training_data_action.dart';
import 'package:neuropic/src/services/game_service.dart';
import 'package:neuropic/src/state/game_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'game_selector.dart';

class GameEffects {

  final GameSelector _selector;
  final GameService _service;

  GameEffects(this._selector, this._service);

  Epic<GameState> getEffects() {
    return combineEpics([
      TypedEpic<GameState, InitToolAction>(_onInitTool),
      TypedEpic<GameState, InitToolSuccessAction>(_onInitToolSuccess),
      TypedEpic<GameState, GetNextSquareAction>(_onGetNextSquare),
      TypedEpic<GameState, StoreTrainingDataAction>(_onStoreTrainingData),
    ]);
  }

  Stream<Object> _onInitTool(Stream<InitToolAction> actions, EpicStore<GameState> store) =>
      Observable(actions).asyncExpand((action) async* {
        final image = ImageElement();
        final completer = Completer();
        image.onLoad.listen((data) {
          completer.complete(null);
        });
        image.src = 'img/reference.png';
        await completer.future;
        yield InitToolSuccessAction(image);
      });

  Stream<Object> _onInitToolSuccess(Stream<InitToolSuccessAction> actions, EpicStore<GameState> store) =>
      Observable(actions).asyncExpand((action) async* {
        yield GetNextSquareAction();
      });

  Stream<Object> _onGetNextSquare(Stream<GetNextSquareAction> actions, EpicStore<GameState> store) =>
      Observable(actions).asyncExpand((action) async* {
        yield CalculateAngleSuccessAction(_service.getAngle(_selector.getSquare(store.state)));
      });

  Stream<Object> _onStoreTrainingData(Stream<StoreTrainingDataAction> actions, EpicStore<GameState> store) =>
      Observable(actions).asyncExpand((action) async* {
        yield GetNextSquareAction();
      });
}
