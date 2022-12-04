import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:the_sss_store/screen/home/home_screen.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';

import '../screen_test.dart';

void main() {
  testWidgets('Home Screen Test View', (WidgetTester tester) async {
    Widget createLoginScreenUnderTest() {
      return createScreenUnderTest(const HomeScreen());
    }

    initializeGetIt();

    await tester.pumpWidget(createLoginScreenUnderTest());

    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Armazéns'), findsOneWidget);
    expect(find.text('Eventos'), findsOneWidget);
    expect(find.text('Calendário'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
    expect(find.byType(MaterialButton), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(6));
  });
}
