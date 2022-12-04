import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:the_sss_store/screen/home/home_screen.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';

import '../widget_test.dart';

//TOOD: Test button tap
void main() {
  initializeGetIt();
  testWidgets('Home Screen Test View', (WidgetTester tester) async {

    await tester.pumpWidget(createWidgetUnderTest(const HomeScreen()));

    expect(find.text('Menu'), findsOneWidget);
    expect(find.byType(StoragesMenuButton), findsOneWidget);
    expect(find.byType(EventsMenuButton), findsOneWidget);
    expect(find.byType(CalendarButton), findsOneWidget);
    expect(find.byType(AdminButton), findsOneWidget);
    expect(find.byType(LogoutButton), findsOneWidget);
  });
  testWidgets('Storages Menu Button widget', (WidgetTester tester) async {
    
    await tester.pumpWidget(createWidgetUnderTest(const StoragesMenuButton()));



    expect(find.text('Armazéns'), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
  });

  testWidgets('Events Menu Button widget', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(const EventsMenuButton()));

    expect(find.text('Eventos'), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
  });

  testWidgets('Calendar Button widget', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(const CalendarButton()));

    expect(find.text('Calendário'), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
  });

  testWidgets('Admin Button widget', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(const AdminButton()));

    expect(find.text('Admin'), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
  });

  testWidgets('Logout Button widget', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(const LogoutButton()));

    expect(find.text('Logout'), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
  });
}
