import 'package:untitled1/infrastructure/counter_model.dart';
import 'package:equatable/equatable.dart';
abstract class CounterState extends Equatable{
  const CounterState();
}

class ReadCounterState extends CounterState {
  const ReadCounterState({required this.result});

  final CounterModel result;

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}

class CounterInitialState extends CounterState {
  const CounterInitialState({required this.result});

  final CounterModel result;

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}

class CurrentState extends CounterState{
   final CounterModel? result;

  CurrentState({this.result});

  get one => result?.one??0;
   get two => result?.two??0;
   get three => result?.three??0;

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}