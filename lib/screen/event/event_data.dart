import 'package:the_sss_store/screen/state_data.dart';
import 'package:the_sss_store/common/data/item_data.dart';

class EventData extends StateData {
  const EventData({
    required this.showLoading,
    required this.name,
    required this.itemData,
    required this.startDate,
    required this.finalDate,
  });

  EventData.initial()
      : showLoading = false,
        name = "",
        startDate = DateTime.now(),
        finalDate = DateTime.now(),
        itemData = const [];

  final bool showLoading;
  final String name;
  final DateTime startDate;
  final DateTime finalDate;
  final List<ItemData> itemData;

  @override
  List<Object?> get props =>
      [showLoading, name, startDate, finalDate, itemData];
}
