import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled1/core/utils/failures.dart';
import 'package:untitled1/domain/counter_interface.dart';
import 'package:untitled1/infrastructure/counter_model.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: CounterInterface)
class CounterImpl implements CounterInterface {
  final FirebaseDatabase _firebaseDatabase;

  CounterImpl(this._firebaseDatabase);

  @override
  Either<Failure, Unit> setCounter(
      {required String counterName, required int count}) {
    try {
      _firebaseDatabase
          .reference()
          .child('counters')
          .child(counterName)
          .set({"count": count});

      return Right(unit);
    } catch (e) {
      log(e.toString());
      return Left(SomeFailure());
    }
  }

  @override
  Future<Either<Failure, CounterModel>> readAllCounters() async {
    CounterModel counterModel = CounterModel(one: 0, two: 0, three: 0);
    try {
      var event = await _firebaseDatabase.reference().child('counters').once();

      if (event.value != null) {
        int countOne = 0;
        int countTwo = 0;
        int countThree = 0;
        if (event.value["One"] != null) {
          countOne = event.value["One"]["count"];
        }
        if (event.value["Two"] != null) {
          countTwo = event.value["Two"]["count"];
        }
        if (event.value["Three"] != null) {
          countThree = event.value["Three"]["count"];
        }

        counterModel =
            CounterModel(two: countTwo, three: countThree, one: countOne);
      } else {
        counterModel = CounterModel(one: 0, three: 0, two: 0);
      }

      return right(counterModel);
    } catch (e) {
      log(e.toString());
      return left(SomeFailure());
    }
  }

  @override
  Either<Failure, Unit> clearAllCounters() {
    try {
      _firebaseDatabase
          .reference()
          .child('counters').remove();

      return Right(unit);
    } catch (e) {
      log(e.toString());
      return Left(SomeFailure());
    }
  }
}
