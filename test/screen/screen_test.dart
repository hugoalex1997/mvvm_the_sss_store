import 'package:flutter/material.dart';

import 'package:the_sss_store/factory/view_model_factory.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:the_sss_store/screen/screen.dart';

Widget createScreenUnderTest(Screen screen) {
  
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
      home: MultiProvider(
        providers: [
          Provider.value(value: getIt.get<ViewModelFactory>()),
        ],
        child: screen,
      ),
    ),
  );
}
