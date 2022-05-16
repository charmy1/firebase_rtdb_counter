import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/application/counter/counter_cubit.dart';
import 'package:untitled1/application/counter/counter_state.dart';
import 'package:untitled1/infrastructure/counter_model.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({
    Key? key,
  }) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  void _incrementCounter(int two,CounterModel? model) {
    log("increment counter page two");

    BlocProvider.of<CounterCubit>(context)
        .increment(counterName: "Two", count: two + 1,model1: model);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        if (state is CurrentState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter ${state.two}"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${state.two}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _incrementCounter(state.two,state.result);
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
