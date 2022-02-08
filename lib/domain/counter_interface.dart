import 'package:dartz/dartz.dart';
import 'package:untitled1/core/utils/failures.dart';
import 'package:untitled1/infrastructure/counter_model.dart';

abstract class CounterInterface {


  Either<Failure, Unit> setCounter({required String counterName,required int count});
  Either<Failure, Unit> clearAllCounters();

   Future<Either<Failure, CounterModel>> readAllCounters();

}