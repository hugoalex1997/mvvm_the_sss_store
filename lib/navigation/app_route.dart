import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef ScreenBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

abstract class AppRoute extends GoRoute {
  AppRoute({
    required String path,
    required ScreenBuilder builder,
  }) : super(
          path: path,
          builder: builder,
        );

  void push(BuildContext context, [Map<String, String> params = const {}]) {
    context.push(path, extra: params);
  }

  void pushAndReplacement(BuildContext context) {
    context.go(path);
  }
}
