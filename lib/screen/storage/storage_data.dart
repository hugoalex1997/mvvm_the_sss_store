import 'package:the_sss_store/screen/state_data.dart';

class StorageData extends StateData {
  const StorageData({
    required this.storageText,
    required this.showEmptyState,
    required this.showLoading,
  });

  const StorageData.initial()
      : storageText = const [],
        showLoading = false,
        showEmptyState = false;

  final List<StorageData> storageText;
  final bool showLoading;
  final bool showEmptyState;

  @override
  List<Object?> get props => [
        storageText,
        showLoading,
        showEmptyState,
      ];
      
}
