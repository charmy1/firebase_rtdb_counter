import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/application/counter/counter_cubit.dart';
import 'package:untitled1/core/injection.dart';
import 'package:untitled1/router/router.gr.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CounterCubit>()..readAll(),
      child: AutoTabsScaffold(
        routes: [
          Page1Router(),
          Page2Router(),
          Page3Router(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.pages),
                label: "Page 1",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pages),
                label: "Page 2",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pages),
                label: "Page 3",
              ),
            ],
          );
        },
        builder: (context, child, animation) {
          return child;
        },
      ),
    );
  }
}
