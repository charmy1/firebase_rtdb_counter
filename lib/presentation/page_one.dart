import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/application/counter/counter_cubit.dart';
import 'package:untitled1/application/counter/counter_state.dart';
import 'package:untitled1/infrastructure/counter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:untitled1/presentation/tabs_page.dart';

class PageOne extends StatefulWidget {
  const PageOne({
    Key? key,
  }) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  void _incrementCounter(int one, CounterModel? model) {
    log("increment counter page one");

    BlocProvider.of<CounterCubit>(context)
        .increment(counterName: "One", count: one + 1, model1: model);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("PageStorageKey"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.looks_one), text: "List1"),
              Tab(icon: Icon(Icons.looks_two), text: "List2"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(key: "key1", string: "List1: "),
            TestList(),
            //_buildList(key: "key2", string: "List2: "),
          ],
        ),
      ),
    );
  }

  Widget _buildList({required String key, required String string}) {
    return PaginateFirestore(
      itemsPerPage: 10,
      //item builder type is compulsory.
      itemBuilder: (context, documentSnapshots, index) {
        final data = documentSnapshots[index].data() as Map?;
        return ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: data == null ? Text('Error in data') : Text(data['name']),
          subtitle: Text(documentSnapshots[index].id),
        );
      },
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance.collection('users').orderBy('name'),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,

      // to fetch real-time data
      isLive: true,
    );
    /*return ListView.builder(
      key: PageStorageKey(key),
      itemBuilder: (_, i) => ListTile(title: Text("${string} ${i}")),
    );*/
  }
/*@override
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
  }*/

}
