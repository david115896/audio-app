import 'dart:async';
import './../apis/api.dart';
import 'bloc.dart';

import './../models/update_model.dart';

class BlocToUpdate extends Bloc {
  Update toUpdateModel = Update(
    id: null,
    name: null,
    description: null,
  );

  final _streamController = StreamController<Update>();
  Stream<Update> get stream => _streamController.stream;
  Sink<Update> get sink => _streamController.sink;

  fetchUpdate() async {
    //final toUpdate = await Api().fetchToUpdate();
    //sink.add(toUpdate);
  }

  BlocToUpdate() {
    //fetchUpdate();
    sink.add(toUpdateModel);
  }

  @override
  void dispose() => _streamController.close();
}
