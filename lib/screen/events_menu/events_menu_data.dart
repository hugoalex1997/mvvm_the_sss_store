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

  EventsMenuData.initial()
      : eventButtonData = const [],
        showLoading = false,
        showEmptyState = false,
        createEventPopup = CreateEventPopupData.initial(),
        removeEventPopup = const PopupData.initial();

  final List<EventButtonData> eventButtonData;
  final bool showLoading;
  final bool showEmptyState;
  final CreateEventPopupData createEventPopup;
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

class CreateEventPopupData extends Equatable {
  const CreateEventPopupData({
    required this.visible,
    required this.error,
    required this.startDate,
    required this.endDate,
  });

  CreateEventPopupData.initial()
      : visible = false,
        error = "",
        startDate = DateTime.now(),
        endDate = DateTime.now();

  CreateEventPopupData.show()
      : visible = true,
        error = "",
        startDate = DateTime.now(),
        endDate = DateTime.now();

  CreateEventPopupData.error(this.error)
      : visible = true,
        startDate = DateTime.now(),
        endDate = DateTime.now();

  CreateEventPopupData.startDate(DateTime date)
      : visible = true,
        error = "",
        startDate = date,
        endDate = DateTime.now();

  CreateEventPopupData.endDate(DateTime date)
      : visible = true,
        error = "",
        startDate = DateTime.now(),
        endDate = date;

  final bool visible;
  final String error;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props => [visible, error, startDate, endDate];

  CreateEventPopupData copyWith({
    bool? visible,
    String? error,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CreateEventPopupData(
      visible: visible ?? this.visible,
      error: error ?? this.error,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
