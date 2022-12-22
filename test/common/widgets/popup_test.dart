import 'package:flutter/material.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/common/widgets/popup.dart';
import 'package:the_sss_store/common/widgets/error_popup_label.dart';

import 'package:mockito/mockito.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  initializeGetIt();
  String title = "popup_test";

  final void Function() callbackTest = MockFunction();

  Widget createPopupWidget() {
    return MaterialApp(
        home: Popup(
      title: title,
      confirmButtonTap: callbackTest,
      cancelButtonTap: callbackTest,
      bodyWidget: Container(),
      popupSize: 69,
      errorLabel: "don't need to test this :D",
    ));
  }

  testWidgets('Test Error Popup Label', (WidgetTester tester) async {
    await tester.pumpWidget(createPopupWidget());

    expect(find.byType(ConfirmTextButton), findsOneWidget);
    expect(find.byType(CancelTextButton), findsOneWidget);
    expect(find.text('Confirmar'), findsOneWidget);
    expect(find.text('Cancelar'), findsOneWidget);
    expect(find.text(title), findsOneWidget);
    expect(find.byType(ErrorPopupLabel), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    verifyNever(callbackTest());
  });

  testWidgets('Test Confirm Text Button Callback', (WidgetTester tester) async {
    await tester.pumpWidget(createPopupWidget());

    await tester.tap(find.byType(ConfirmTextButton));

    verify(callbackTest()).called(1);
  });

  testWidgets('Test Cancel Text Button Callback', (WidgetTester tester) async {
    await tester.pumpWidget(createPopupWidget());

    await tester.tap(find.byType(CancelTextButton));

    verify(callbackTest()).called(1);
  });
}
