
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  FirebaseDatabase get firebaseDataBase => FirebaseDatabase.instance;
}
