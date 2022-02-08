import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled1/router/router.gr.dart';

import 'core/injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Environment.prod);

  runApp(const MyApp());
}
var appRouter= AppRouter();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //todo theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(
        ),
      routeInformationParser: appRouter.defaultRouteParser(),
      builder: (_, router) {
        return router!;
      },
    );
  }
}
