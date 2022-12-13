import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
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
        .map((eventList) => eventList.map(EventButtonData.fromEvent).toList())
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
    PopupData? createEventPopup,
    PopupData? removeEventPopup,
  }) {
    button ??= value.eventButtonData;
    isLoading ??= value.showLoading;
    createEventPopup ??= value.createEventPopup;
    removeEventPopup ??= value.removeEventPopup;

    stateData = EventsMenuData(
      eventButtonData: button,
      showEmptyState: button.isEmpty && !isLoading,
      showLoading: isLoading,
      createEventPopup: createEventPopup,
      removeEventPopup: removeEventPopup,
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
    _updateState(createEventPopup: const PopupData.show());
  }

  void showRemoveEventPopup() {
    _updateState(removeEventPopup: const PopupData.show());
  }

  void hidePopup() {
    _updateState(
        createEventPopup: const PopupData.initial(),
        removeEventPopup: const PopupData.initial());
  }

  Future<bool> createEvent(String name) async {
    if (name.isEmpty) {
      _updateState(
          createEventPopup: const PopupData.error("Deve inserir um nome!"));
      return false;
    }

    _eventsMenuRepository.createEvent(name);
    return true;
  }

  Future<bool> removeEvent(String name) async {
    if (name.isEmpty) {
      //TODO: When an event is chosen, this error must be removed.
      _updateState(
          removeEventPopup:
              const PopupData.error("Nenhum evento selecionado!"));
      return false;
    }

    _eventsMenuRepository.removeEvent(name);
    return true;
  }
}
