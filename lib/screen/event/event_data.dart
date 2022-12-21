import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/screen/state_data.dart';
import 'package:the_sss_store/common/data/item_data.dart';

class EventData extends StateData {
  const EventData(
      {required this.showLoading,
      required this.showEmptyState,
      required this.name,
      required this.startDate,
      required this.endDate,
      required this.itemData,
      required this.addItemPopup,
      required this.removeItemPopup,
      required this.changeEventPopup});

  const EventData.initial()
      : showLoading = false,
        showEmptyState = false,
        name = "",
        startDate = "",
        endDate = "",
        itemData = const [],
        addItemPopup = const PopupData.initial(),
        removeItemPopup = const PopupData.initial(),
        changeEventPopup = const PopupData.initial();

  final bool showLoading;
  final bool showEmptyState;
  final String name;
  final String startDate;
  final String endDate;
  final List<ItemData> itemData;
  final PopupData addItemPopup;
  final PopupData removeItemPopup;
  final PopupData changeEventPopup;

  @override
  List<Object?> get props =>
      [showLoading, showEmptyState, name, startDate, endDate, itemData];
}
