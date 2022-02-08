import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled1/domain/counter_interface.dart';
import 'package:untitled1/infrastructure/counter_model.dart';

import 'counter_state.dart';

@injectable
class CounterCubit extends Cubit<CounterState> {
  final CounterInterface _counterInterface;

  CounterCubit(this._counterInterface)
      : super(CounterInitialState(
            result: CounterModel(one: 0, three: 0, two: 0)));

  void increment(
      {required String counterName,
      required int count,
      required CounterModel? model1}) {
    var result =
        _counterInterface.setCounter(counterName: counterName, count: count);
    result.fold((l) {
      emit(ReadCounterState(
          result: CounterModel(
              one: CurrentState().one,
              three: CurrentState().three,
              two: CurrentState().two)));
    }, (r) {
      if (counterName == "One") {
        emit(CurrentState(
            result: CounterModel(
                one: count, three: model1?.three ?? 0, two: model1?.two ?? 0)));
      } else if (counterName == "Two") {
        emit(CurrentState(
            result: CounterModel(
                one: model1?.one ?? 0, three: model1?.three ?? 0, two: count)));
      } else {
        emit(CurrentState(
            result: CounterModel(
                one: model1?.one ?? 0, three: count, two: model1?.two ?? 0)));
      }
    });
  }

  Future<void> readAll() async {
    log("readall");
    var result = await _counterInterface.readAllCounters();

    if (result.isRight()) {
      CounterModel model = CounterModel(one: 0, three: 0, two: 0);
      result.fold((l) => null, (r) {
        model = r;
      });
      emit(CurrentState(result: model));
    } else {
      emit(CurrentState());
    }
  }

  Future<void> clearAll() async {
    var result = await _counterInterface.clearAllCounters();
    if (result.isRight()) {
      emit(CurrentState(result: CounterModel(two: 0, three: 0, one: 0)));
    } else {
      emit(CurrentState());
    }
  }
}
