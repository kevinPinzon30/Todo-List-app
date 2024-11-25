import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/to_do/presentation/screens/to_do_list.dart';

import '../../features/authentication/presentation/screens/login.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'toDo',
            builder: (context, state) => TodoList(),
          ),
          GoRoute(
            path: 'login',
            builder: (context, state) => LoginScreen(),
          ),
          // GoRoute(
          //   path: 'welcome',
          //   builder: (context, state) => LoginScreen(),
          // ),
        ],
      ),
    ],
  );
}
