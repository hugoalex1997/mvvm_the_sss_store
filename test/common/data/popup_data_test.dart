import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

void main() {
  test('initial method is returning the correct data', () {
    PopupData popupData = const PopupData(visible: false, error: "");

    PopupData initialData = const PopupData.initial();

    expect(initialData, popupData);
  });

  test('show method is returning the correct data', () {
    PopupData popupData = const PopupData(visible: true, error: "");

    PopupData initialData = const PopupData.show();

    expect(initialData, popupData);
  });

  test('error method is returning the correct data', () {
    String error = "test_error";
    PopupData popupData = PopupData(visible: true, error: error);

    PopupData initialData = PopupData.error(error);

    expect(initialData, popupData);
  });

  test('Event Button Data is correctly created from a Event Class instance',
      () {
    String error = "test_error";
    PopupData popupData = PopupData(visible: true, error: error);

    PopupData initialData1 = popupData.copyWith();
    PopupData initialData2 = popupData.copyWith(visible: true, error: error);
    PopupData initialData3 = popupData.copyWith(visible: false, error: "");

    expect(initialData1, popupData);
    expect(initialData2, popupData);
    expect(initialData3 != popupData, true);
  });
}
