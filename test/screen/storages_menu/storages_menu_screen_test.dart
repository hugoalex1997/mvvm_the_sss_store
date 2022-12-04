import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:the_sss_store/screen/login/login_screen.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';

import '../widget_test.dart';

void main() {
  initializeGetIt();
  testWidgets('Login Screen View', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(const LoginScreen()));

    expect(find.byType(Scaffold), findsOneWidget);

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Nome de Utilizador'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(Column), findsOneWidget);
  });
}
