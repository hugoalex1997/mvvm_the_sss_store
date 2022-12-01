import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:the_sss_store/widget/global_provider.dart';
import 'package:the_sss_store/services/firebase/firebase_init.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.routeInformationParser,
    required this.routerDelegate,
  }) : super(key: key);

  final RouteInformationParser<Object> routeInformationParser;
  final RouterDelegate<Object> routerDelegate;

  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      child: MaterialApp.router(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routeInformationParser: routeInformationParser,
        routerDelegate: routerDelegate,
      ),
    );
  }
}
