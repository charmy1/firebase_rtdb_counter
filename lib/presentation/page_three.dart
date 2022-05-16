import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/application/counter/counter_cubit.dart';
import 'package:untitled1/application/counter/counter_state.dart';
import 'package:untitled1/infrastructure/counter_model.dart';

class PageThree extends StatefulWidget {
  const PageThree({
    Key? key,
  }) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {


  void _incrementCounter(int three,CounterModel? model) {
    log("increment counter page three");

    BlocProvider.of<CounterCubit>(context)
        .increment(counterName: "Three", count: three + 1,model1: model);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        if (state is CurrentState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter ${state.three}"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${state.three}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _incrementCounter(state.three,state.result);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
