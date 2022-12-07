import 'package:the_sss_store/screen/state_data.dart';

class EventData extends StateData {
  const EventData({
    required this.storageText,
    required this.showEmptyState,
    required this.showLoading,
  });

  const EventData.initial()
      : storageText = const [],
        showLoading = false,
        showEmptyState = false;

  final List<EventData> storageText;
  final bool showLoading;
  final bool showEmptyState;

  @override
  List<Object?> get props => [
        storageText,
        showLoading,
        showEmptyState,
      ];
}
