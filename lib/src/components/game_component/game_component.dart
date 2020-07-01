import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:neuropic/src/actions/get_next_square_action.dart';
import 'package:neuropic/src/actions/init_tool_action.dart';
import 'package:neuropic/src/components/game_component/board_component/board_component.dart';
import 'package:neuropic/src/components/game_component/results_component/results_component.dart';
import 'package:neuropic/src/services/game_dispatcher.dart';
import 'package:neuropic/src/services/game_providers.dart';
import 'package:neuropic/src/state/game_state.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'snake-game',
  styleUrls: ['game_component.css'],
  templateUrl: 'game_component.html',
  directives: [BoardComponent, ResultsComponent],
  providers: [GameProviders.providers],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class GameComponent implements OnDestroy {
  final Store<GameState> _store;
  final NgZone _zone;
  final ChangeDetectorRef _detector;
  final GameDispatcher _dispatcher;
  final List<StreamSubscription> _subscriptions = [];

  Timer _gameTimer;

  GameState get state => _store.state;

  GameComponent(
      this._store,
      this._zone,
      this._detector,
      this._dispatcher)
  {
    _init();
  }
  void _init() {
    _zone.runOutsideAngular(() {
      _subscriptions.addAll([
        _store.onChange.listen((_) {
          _zone.run(_detector.markForCheck);
        }),
        document.onMouseUp.listen((_) => _dispatcher.dispatch(GetNextSquareAction())),
        _dispatcher.onAction.listen(_store.dispatch),
      ]);
      _dispatcher.dispatch(InitToolAction());
    });
  }

  @override
  void ngOnDestroy() {
    _gameTimer.cancel();
    _subscriptions.clear();
    _store?.teardown();
  }
}
