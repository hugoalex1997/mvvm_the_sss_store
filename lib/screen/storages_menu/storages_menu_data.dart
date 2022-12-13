import 'package:equatable/equatable.dart';
import 'package:the_sss_store/model/storage.dart';
import 'package:the_sss_store/screen/state_data.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

class StoragesMenuData extends StateData {
  const StoragesMenuData({
    required this.storageButtonData,
    required this.showEmptyState,
    required this.showLoading,
    required this.createStoragePopup,
    required this.removeStoragePopup,
  });

  const StoragesMenuData.initial()
      : storageButtonData = const [],
        showLoading = false,
        showEmptyState = false,
        createStoragePopup = const PopupData.initial(),
        removeStoragePopup = const PopupData.initial();

  final List<StorageButtonData> storageButtonData;
  final bool showLoading;
  final bool showEmptyState;
  final PopupData createStoragePopup;
  final PopupData removeStoragePopup;

  @override
  List<Object?> get props => [
        storageButtonData,
        showLoading,
        showEmptyState,
        createStoragePopup,
        removeStoragePopup,
      ];
}

class StorageButtonData extends Equatable {
  const StorageButtonData({
    required this.name,
  });

  StorageButtonData.fromStorage(Storage storage) : name = storage.name;

  final String name;

  @override
  List<Object?> get props => [name];

  StorageButtonData copyWith({
    String? name,
  }) {
    return StorageButtonData(
      name: name ?? this.name,
    );
  }
}
