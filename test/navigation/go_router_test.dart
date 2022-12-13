import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:the_sss_store/inject/dependency_injection.dart';

import 'package:the_sss_store/common/widgets/global_provider.dart';
import 'package:the_sss_store/navigation/go_router.dart';

import 'package:go_router/go_router.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/home/home_screen.dart';

String getRouterKey(String route) {
  return 'key_$route';
}

Widget createRouterAppTest(GoRouter router) {
  return GlobalProvider(
    child: MaterialApp.router(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    ),
  );
}

extension PumpApp on WidgetTester {
  Future<void> pumpRealRouterApp(
    Widget Function(Widget child) builder,
  ) {
    final _router = createRouter();

    return pumpWidget(createRouterAppTest(_router));
  }

  Future<void> pumpTestRouterApp(Widget widget) {
    const initialLocation = '/_initial';

    final _router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: initialLocation,
          builder: (context, state) => widget,
        ),
        ...Routes()
            .props
            .map(
              (e) => GoRoute(
                path: e! as String,
                builder: (context, state) => Container(
                  key: Key(
                    getRouterKey(e as String),
                  ),
                ),
              ),
            )
            .toList()
      ],
    );

    return pumpWidget(createRouterAppTest(_router));
  }
}

void main() {
  initializeGetIt();
  testWidgets('Home Screen is root', (WidgetTester tester) async {
    await tester.pumpRealRouterApp(
      (child) => child,
    );

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
  });
}
