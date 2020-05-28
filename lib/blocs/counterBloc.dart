import 'dart:async';

class CounterBase {}

class Increment extends CounterBase {}

class Decrement extends CounterBase {}

class CounterBloc {
  StreamController<CounterBase> _input = StreamController();
  StreamController<int> _output = StreamController();
  int _counter = 0;

  CounterBloc() {
    _input.stream.listen(_onEvent);
  }

  Stream<int> get counterStream => _output.stream;

  StreamSink<CounterBase> get sendEvent => _input.sink;

  void dispose() {
    _input.close();
    _output.close();
  }

  void _onEvent(CounterBase event) {
    if (event is Increment) {
      _counter += 1;
    } else if (event is Decrement) {
      _counter -= 1;
    }

    _output.add(_counter);
  }
}
