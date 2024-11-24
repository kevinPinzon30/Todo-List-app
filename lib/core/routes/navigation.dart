import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/to_do/presentation/screens/to_do_list.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return TodoList();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'toDo',
            builder: (context, state) => TodoList(),
          ),
        ],
      ),
    ],
  );
}
