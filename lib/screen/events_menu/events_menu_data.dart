import 'package:equatable/equatable.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/model/event.dart';
import 'package:the_sss_store/screen/state_data.dart';

class EventsMenuData extends StateData {
  const EventsMenuData({
    required this.eventButtonData,
    required this.showEmptyState,
    required this.showLoading,
    required this.createEventPopup,
    required this.removeEventPopup,
  });

  const EventsMenuData.initial()
      : eventButtonData = const [],
        showLoading = false,
        showEmptyState = false,
        createEventPopup = const PopupData.initial(),
        removeEventPopup = const PopupData.initial();

  final List<EventButtonData> eventButtonData;
  final bool showLoading;
  final bool showEmptyState;
  final PopupData createEventPopup;
  final PopupData removeEventPopup;

  @override
  List<Object?> get props => [
        eventButtonData,
        showLoading,
        showEmptyState,
        createEventPopup,
        removeEventPopup,
      ];
}

class EventButtonData extends Equatable {
  const EventButtonData({
    required this.name,
  });

  EventButtonData.fromEvent(Event event) : name = event.name;

  final String name;

  @override
  List<Object?> get props => [name];

  EventButtonData copyWith({
    String? name,
  }) {
    return EventButtonData(
      name: name ?? this.name,
    );
  }
}
