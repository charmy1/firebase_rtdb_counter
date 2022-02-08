import 'package:auto_route/auto_route.dart';
import 'package:untitled1/presentation/bottom_navigation_page.dart';
import 'package:untitled1/presentation/page_one.dart';
import 'package:untitled1/presentation/page_three.dart';
import 'package:untitled1/presentation/page_two.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: BottomNavigationPage, initial: true, children: [
      AutoRoute(path: 'one', name: 'Page1Router', page: PageOne),
      AutoRoute(
        path: 'three',
        name: 'Page3Router',
        page: PageThree,
      ),
      AutoRoute(
        path: 'two',
        name: 'Page2Router',
        page: PageTwo,
      )
    ]),
  ],
)
class $AppRouter {}
