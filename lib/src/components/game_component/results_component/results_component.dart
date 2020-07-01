import 'package:angular/angular.dart';
import 'package:neuropic/src/services/game_selector.dart';
import 'package:neuropic/src/state/game_state.dart';

@Component(
  selector: 'results',
  styleUrls: ['results_component.css'],
  templateUrl: 'results_component.html',
  directives: [NgFor],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ResultsComponent {

  @Input()
  GameState state;

  final GameSelector _selector;

  ResultsComponent(this._selector);
}
