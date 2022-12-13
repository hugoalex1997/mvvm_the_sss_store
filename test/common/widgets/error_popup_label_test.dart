import 'package:flutter/material.dart';
import 'package:the_sss_store/common/widgets/error_popup_label.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  initializeGetIt();

  String errorText = "error_test";
  testWidgets('Test Error Popup Label', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: ErrorPopupLabel(errorText: errorText)));
    expect(find.text(errorText), findsOneWidget);
  });
}
