import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';
import 'package:the_sss_store/repository/events_menu_repository.dart';

@injectable
class EventsMenuViewModel extends ViewModel<EventsMenuData> {
  EventsMenuViewModel(this._eventsMenuRepository)
      : super(const EventsMenuData.initial());

  final EventsMenuRepository _eventsMenuRepository;

  StreamSubscription<List<EventButtonData>>? _eventsSub;

  @visibleForTesting
  EventsMenuRepository getEventsMenuRepository() {
    return _eventsMenuRepository;
  }

  Future<void> init() async {
    _eventsSub = _eventsMenuRepository
        .observeEventList()
        .map((eventList) =>
            eventList.map(EventButtonData.fromEvent).toList())
        .listen(_onEventChanged);

    await _updateList();
  }

  @override
  void dispose() {
    _eventsSub?.cancel();
    super.dispose();
  }

  void _updateState({
    List<EventButtonData>? button,
    bool? isLoading,
    bool? showCreateEventPopup,
    bool? showRemoveEventPopup,
  }) {
    button ??= value.eventButtonData;
    isLoading ??= value.showLoading;
    showCreateEventPopup ??= value.showCreateEventPopup;
    showRemoveEventPopup ??= value.showRemoveEventPopup;

    stateData = EventsMenuData(
      eventButtonData: button,
      showEmptyState: button.isEmpty && !isLoading,
      showLoading: isLoading,
      showCreateEventPopup: showCreateEventPopup,
      showRemoveEventPopup: showRemoveEventPopup,
    );
  }

  Future<void> _updateList() async {
    _updateState(isLoading: true);

    await _eventsMenuRepository.fetchEventList();

    _updateState(isLoading: false);
  }

  void _onEventChanged(List<EventButtonData> button) {
    _updateState(button: button);
  }

  void showCreateEventPopup() {
    _updateState(showCreateEventPopup: true);
  }

  void showRemoveEventPopup() {
    _updateState(showRemoveEventPopup: true);
  }

  void hidePopup() {
    _updateState(showCreateEventPopup: false, showRemoveEventPopup: false);
  }

  Future<bool> createEvent(String name) async {
    if (name.isEmpty) {
      return false;
    }

    _eventsMenuRepository.createEvent(name);
    return true;
  }

  Future<bool> removeEvent(String name) async {
    if (name.isEmpty) {
      return false;
    }

    _eventsMenuRepository.removeEvent(name);
    return true;
  }
}
