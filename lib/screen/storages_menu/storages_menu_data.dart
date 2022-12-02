import 'package:the_sss_store/screen/state_data.dart';
import 'package:the_sss_store/widget/storage_button.dart';

class StoragesMenuData extends StateData {
  const StoragesMenuData({
    required this.storageText,
    required this.showEmptyState,
    required this.showLoading,
  });

  const StoragesMenuData.initial()
      : storageText = const [],
        showLoading = false,
        showEmptyState = false;

  final List<StorageButtonData> storageText;
  final bool showLoading;
  final bool showEmptyState;

  @override
  List<Object?> get props => [
        storageText,
        showLoading,
        showEmptyState,
      ];
      
}
