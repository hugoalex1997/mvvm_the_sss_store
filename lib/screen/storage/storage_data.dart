import 'package:the_sss_store/screen/state_data.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/common/data/item_data.dart';

class StorageData extends StateData {
  const StorageData({
    required this.name,
    required this.itemData,
    required this.showEmptyState,
    required this.showLoading,
    required this.addItemPopup,
    required this.removeItemPopup,
  });

  const StorageData.initial()
      : name = "",
        itemData = const [],
        showLoading = false,
        showEmptyState = false,
        addItemPopup = const PopupData.initial(),
        removeItemPopup = const PopupData.initial();

  final String name;
  final List<ItemData> itemData;
  final bool showLoading;
  final bool showEmptyState;
  final PopupData addItemPopup;
  final PopupData removeItemPopup;

  @override
  List<Object?> get props => [
        name,
        itemData,
        showLoading,
        showEmptyState,
        addItemPopup,
        removeItemPopup
      ];
}
