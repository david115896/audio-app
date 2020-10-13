import 'dart:async';
import './bloc.dart';

class BlocMusics extends Bloc {
  int index = 0;
  final _streamController = StreamController<int>();
  Stream<int> get stream => _streamController.stream;
  Sink<int> get sink => _streamController.sink;

  BlocMusics() {
    sink.add(index);
  }

  @override
  void dispose() => _streamController.close();
}
