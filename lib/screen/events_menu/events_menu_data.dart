import 'package:equatable/equatable.dart';
import 'package:the_sss_store/model/event.dart';
import 'package:the_sss_store/screen/state_data.dart';

class EventsMenuData extends StateData {
  const EventsMenuData({
    required this.eventButtonData,
    required this.showEmptyState,
    required this.showLoading,
    required this.showCreateEventPopup,
    required this.showRemoveEventPopup,
  });

  const EventsMenuData.initial()
      : eventButtonData = const [],
        showLoading = false,
        showEmptyState = false,
        showCreateEventPopup = false,
        showRemoveEventPopup = false;

  final List<EventButtonData> eventButtonData;
  final bool showLoading;
  final bool showEmptyState;
  final bool showCreateEventPopup;
  final bool showRemoveEventPopup;

  @override
  List<Object?> get props => [
        eventButtonData,
        showLoading,
        showEmptyState,
        showCreateEventPopup,
        showRemoveEventPopup,
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
