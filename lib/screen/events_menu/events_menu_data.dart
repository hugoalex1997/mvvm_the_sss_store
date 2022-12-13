import 'package:equatable/equatable.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
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
        showCreateEventPopup = const PopupData.initial(),
        showRemoveEventPopup = const PopupData.initial();

  final List<EventButtonData> eventButtonData;
  final bool showLoading;
  final bool showEmptyState;
  //TODO: This variables should be renamed
  final PopupData showCreateEventPopup;
  final PopupData showRemoveEventPopup;

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
