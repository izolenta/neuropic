// GENERATED CODE - DO NOT MODIFY BY HAND

part of neuropic.state.game_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GameState extends GameState {
  @override
  final ImageElement image;
  @override
  final int imagePartX;
  @override
  final int imagePartY;
  @override
  final List<TrainingData> trainingData;

  factory _$GameState([void Function(GameStateBuilder) updates]) =>
      (new GameStateBuilder()..update(updates)).build();

  _$GameState._(
      {this.image, this.imagePartX, this.imagePartY, this.trainingData})
      : super._() {
    if (image == null) {
      throw new BuiltValueNullFieldError('GameState', 'image');
    }
    if (imagePartX == null) {
      throw new BuiltValueNullFieldError('GameState', 'imagePartX');
    }
    if (imagePartY == null) {
      throw new BuiltValueNullFieldError('GameState', 'imagePartY');
    }
    if (trainingData == null) {
      throw new BuiltValueNullFieldError('GameState', 'trainingData');
    }
  }

  @override
  GameState rebuild(void Function(GameStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GameStateBuilder toBuilder() => new GameStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GameState &&
        image == other.image &&
        imagePartX == other.imagePartX &&
        imagePartY == other.imagePartY &&
        trainingData == other.trainingData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, image.hashCode), imagePartX.hashCode),
            imagePartY.hashCode),
        trainingData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GameState')
          ..add('image', image)
          ..add('imagePartX', imagePartX)
          ..add('imagePartY', imagePartY)
          ..add('trainingData', trainingData))
        .toString();
  }
}

class GameStateBuilder implements Builder<GameState, GameStateBuilder> {
  _$GameState _$v;

  ImageElement _image;
  ImageElement get image => _$this._image;
  set image(ImageElement image) => _$this._image = image;

  int _imagePartX;
  int get imagePartX => _$this._imagePartX;
  set imagePartX(int imagePartX) => _$this._imagePartX = imagePartX;

  int _imagePartY;
  int get imagePartY => _$this._imagePartY;
  set imagePartY(int imagePartY) => _$this._imagePartY = imagePartY;

  List<TrainingData> _trainingData;
  List<TrainingData> get trainingData => _$this._trainingData;
  set trainingData(List<TrainingData> trainingData) =>
      _$this._trainingData = trainingData;

  GameStateBuilder();

  GameStateBuilder get _$this {
    if (_$v != null) {
      _image = _$v.image;
      _imagePartX = _$v.imagePartX;
      _imagePartY = _$v.imagePartY;
      _trainingData = _$v.trainingData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GameState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GameState;
  }

  @override
  void update(void Function(GameStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GameState build() {
    final _$result = _$v ??
        new _$GameState._(
            image: image,
            imagePartX: imagePartX,
            imagePartY: imagePartY,
            trainingData: trainingData);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
