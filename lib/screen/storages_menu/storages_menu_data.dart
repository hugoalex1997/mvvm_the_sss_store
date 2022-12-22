import 'package:equatable/equatable.dart';
import 'package:the_sss_store/model/storage.dart';
import 'package:the_sss_store/screen/state_data.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

class StoragesMenuData extends StateData {
  const StoragesMenuData({
    required this.storagesData,
    required this.showEmptyState,
    required this.showLoading,
    required this.createStoragePopup,
    required this.removeStoragePopup,
  });

  const StoragesMenuData.initial()
      : storagesData = const [],
        showLoading = false,
        showEmptyState = false,
        createStoragePopup = const PopupData.initial(),
        removeStoragePopup = const PopupData.initial();

  final List<StorageData> storagesData;
  final bool showLoading;
  final bool showEmptyState;
  final PopupData createStoragePopup;
  final PopupData removeStoragePopup;

  @override
  List<Object?> get props => [
        storagesData,
        showLoading,
        showEmptyState,
        createStoragePopup,
        removeStoragePopup,
      ];
}

class StorageData extends Equatable {
  const StorageData({
    required this.name,
  });

  StorageData.fromStorage(Storage storage) : name = storage.name;

  final String name;

  @override
  List<Object?> get props => [name];

  StorageData copyWith({
    String? name,
  }) {
    return StorageData(
      name: name ?? this.name,
    );
  }
}
