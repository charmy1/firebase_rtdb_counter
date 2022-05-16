import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  StreamController<List<DocumentSnapshot>> _streamController =
  StreamController<List<DocumentSnapshot>>();//keep list of snapshots , instead of list of streams

  List<DocumentSnapshot> _list = [];

  bool _isRequesting = false;
  bool _isFinish = false;

  void onChangeData(List<DocumentChange> documentChanges) {

    var isChange = false;
    documentChanges.forEach((docChange) {

      //use the default enums here for relatime update
      if (docChange.type == DocumentChangeType.removed) {
        _list.removeWhere((item) {
          return docChange.doc.id == item.id;
        });
        isChange = true;
      } else {

        if (docChange.type == DocumentChangeType.modified) {
          int indexWhere = _list.indexWhere((item) {
            return docChange.doc.id == item.id;
          });

          if (indexWhere >= 0) {
            _list[indexWhere] = docChange.doc;
          }
          isChange = true;
        }
      }
    });

    if(isChange) {
      _streamController.add(_list);
    }
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((data) => onChangeData(data.docChanges));

    requestNextPage();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
            requestNextPage();
          }
          return true;
        },
        child: StreamBuilder<List<DocumentSnapshot>>(
          stream: _streamController.stream,//use the stream ,
          builder: (BuildContext context,
              AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                log("Items: " + (snapshot.data?.length??0).toString());
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
                  itemCount: snapshot.data?.length??0,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child:  ListTile(
                      title:  Text(snapshot.data?[index]['name']),

                    ),
                  ),
                );
            }
          },
        ));
  }

  void requestNextPage() async {
    if (!_isRequesting && !_isFinish) {
      QuerySnapshot querySnapshot;
      _isRequesting = true;
      if (_list.isEmpty) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .orderBy('name')
            .limit(5)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .orderBy('name')
            .startAfterDocument(_list[_list.length - 1])
            .limit(5)
            .get();
      }

      if (querySnapshot != null) {
        int oldSize = _list.length;
        _list.addAll(querySnapshot.docs);
        int newSize = _list.length;
        if (oldSize != newSize) {
          log("_streamController");
          _streamController.add(_list);
        } else {
          _isFinish = true;
        }
      }
      _isRequesting = false;
    }
  }
}