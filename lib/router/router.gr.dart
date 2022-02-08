// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../presentation/bottom_navigation_page.dart' as _i1;
import '../presentation/page_one.dart' as _i2;
import '../presentation/page_three.dart' as _i3;
import '../presentation/page_two.dart' as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    BottomNavigationRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.BottomNavigationPage());
    },
    Page1Router.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.PageOne());
    },
    Page3Router.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.PageThree());
    },
    Page2Router.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PageTwo());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(BottomNavigationRoute.name, path: '/', children: [
          _i5.RouteConfig(Page1Router.name,
              path: 'one', parent: BottomNavigationRoute.name),
          _i5.RouteConfig(Page3Router.name,
              path: 'three', parent: BottomNavigationRoute.name),
          _i5.RouteConfig(Page2Router.name,
              path: 'two', parent: BottomNavigationRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.BottomNavigationPage]
class BottomNavigationRoute extends _i5.PageRouteInfo<void> {
  const BottomNavigationRoute({List<_i5.PageRouteInfo>? children})
      : super(BottomNavigationRoute.name, path: '/', initialChildren: children);

  static const String name = 'BottomNavigationRoute';
}

/// generated route for
/// [_i2.PageOne]
class Page1Router extends _i5.PageRouteInfo<void> {
  const Page1Router() : super(Page1Router.name, path: 'one');

  static const String name = 'Page1Router';
}

/// generated route for
/// [_i3.PageThree]
class Page3Router extends _i5.PageRouteInfo<void> {
  const Page3Router() : super(Page3Router.name, path: 'three');

  static const String name = 'Page3Router';
}

/// generated route for
/// [_i4.PageTwo]
class Page2Router extends _i5.PageRouteInfo<void> {
  const Page2Router() : super(Page2Router.name, path: 'two');

  static const String name = 'Page2Router';
}
