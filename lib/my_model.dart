import 'dart:async';

class MyModel {
  int _secondCount = 0;
  int _thirdCount = 0;
  int _value = 0;

  StreamController<int> _secondCountController = StreamController();
  Stream<int> get secondCountStream => _secondCountController.stream;

  StreamController<int> _thirdCountController = StreamController();
  Stream<int> get thirdCountStream => _thirdCountController.stream;

  StreamController<int> _valueController = StreamController();
  Stream<int> get valueStream => _valueController.stream;

  void updateSecond() {
    this._secondCountController.sink.add(_secondCount++);
  }

  void updateThird() {
    this._thirdCountController.sink.add(_thirdCount++);
  }

  void changeValue() {
    this._value += 1;
    _valueController.sink.add(this._value);
  }

  void dispose() {
    this._secondCountController.close();
    this._thirdCountController.close();
    this._valueController.close();
  }
}
