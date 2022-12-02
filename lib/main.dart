import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_sss_store/app.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/navigation/go_router.dart';

import 'package:the_sss_store/services/firebase/firebase_init.dart';
import 'package:injectable/injectable.dart';

@preResolve
Future<FirebaseService> get firebaseService => FirebaseService.init();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  initializeGetIt();

  final router = createRouter();

  firebaseService;
  
  return runApp(
    App(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    ),
  );
}
