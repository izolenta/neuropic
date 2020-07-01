import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:neuropic/src/actions/get_next_square_action.dart';
import 'package:neuropic/src/actions/init_tool_action.dart';
import 'package:neuropic/src/actions/init_tool_success_action.dart';
import 'package:neuropic/src/actions/store_training_data_action.dart';
import 'package:neuropic/src/services/game_selector.dart';
import 'package:neuropic/src/state/game_state.dart';
import 'package:perceptron/perceptron.dart';
import 'package:redux/redux.dart';


class GameReducer {

  final rand = Random();
  final GameSelector _selector;

  Reducer<GameState> _reducer;

  GameReducer(this._selector) {
    _reducer = combineReducers([
      TypedReducer<GameState, InitToolSuccessAction>(_onInitToolSuccess),
      TypedReducer<GameState, GetNextSquareAction>(_onGetNextSquare),
      TypedReducer<GameState, StoreTrainingDataAction>(_onStoreTrainingData),
    ]);
  }

  GameState getState(GameState state, Object action) {
    return _reducer(state, action);
  }

  GameState _onInitToolSuccess(GameState state, InitToolSuccessAction action) =>
    state.rebuild((s) {
      s
        ..image = action.image;
    });

  GameState _onGetNextSquare(GameState state, GetNextSquareAction action) =>
      state.rebuild((s) {
        s
          ..imagePartX = rand.nextInt(state.image.width-7)
          ..imagePartY = rand.nextInt(state.image.height-7);
      });

  GameState _onStoreTrainingData(GameState state, StoreTrainingDataAction action) {
    final rebuilt = state.rebuild((s) =>
      s..trainingData.add(TrainingData(_selector.getSquare(state).map((n) => n/256).toList(), action.output)));
    if (rebuilt.trainingData.length % 10 == 0) {
      print('count: ${rebuilt.trainingData.length}');
    }
    if (rebuilt.trainingData.length % 100 == 0) {
      print(jsonEncode(rebuilt.trainingData));
    }
    return rebuilt;
  }

}