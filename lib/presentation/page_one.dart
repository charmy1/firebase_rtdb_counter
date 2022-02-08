import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/application/counter_cubit.dart';
import 'package:untitled1/application/counter_state.dart';
import 'package:untitled1/infrastructure/counter_model.dart';

class PageOne extends StatefulWidget {
  const PageOne({
    Key? key,
  }) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {


  void _incrementCounter(int one,CounterModel? model) {
    log("increment counter page one");

    BlocProvider.of<CounterCubit>(context)
        .increment(counterName: "One", count: one + 1,model1:model );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        if (state is CurrentState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter ${state.one}"),
              actions: <Widget>[
                TextButton(
                  child: Text('Clear all counters ',style: TextStyle(color: Colors.white),),
                  style: TextButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).clearAll();

                  },
                )

              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${state.one}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _incrementCounter(state.one,state.result);
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
