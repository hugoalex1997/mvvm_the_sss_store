import 'package:equatable/equatable.dart';
import 'package:the_sss_store/screen/state_data.dart';
import 'package:the_sss_store/model/item.dart';

class StorageData extends StateData {
  const StorageData({
    required this.name,
    required this.itemData,
    required this.showEmptyState,
    required this.showLoading,
    required this.showAddItemPopup,
    required this.showRemoveItemPopup,
  });

  const StorageData.initial()
      : 
        name = "",
        itemData = const [],
        showLoading = false,
        showEmptyState = false,
        showAddItemPopup = false,
        showRemoveItemPopup = false;

  final String name;
  final List<ItemData> itemData;
  final bool showLoading;
  final bool showEmptyState;
  final bool showAddItemPopup;
  final bool showRemoveItemPopup;

  @override
  List<Object?> get props => [name, itemData, showLoading, showEmptyState, showAddItemPopup, showRemoveItemPopup];
}

class ItemData extends Equatable {
  const ItemData({
    required this.name,
    required this.available,
    required this.stock,
  });

  ItemData.fromStorage(Item item)
      : name = item.name,
        available = item.available,
        stock = item.stock;

  final String name;
  final int available;
  final int stock;

  @override
  List<Object?> get props => [name];

  ItemData copyWith({
    String? name,
    int? available,
    int? stock,
  }) {
    return ItemData(
      name: name ?? this.name,
      available: available ?? this.available,
      stock: stock ?? this.stock,
    );
  }
}
