import 'package:flutter/material.dart';

import 'package:the_sss_store/factory/view_model_factory.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:provider/provider.dart';

Widget createWidgetUnderTest(Widget widget) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
      home: MultiProvider(
        providers: [
          Provider.value(value: getIt.get<ViewModelFactory>()),
        ],
        child: widget,
      ),
    ),
  );
}
