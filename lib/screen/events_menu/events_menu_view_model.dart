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
      : super(EventsMenuData.initial());

  final EventsMenuRepository _eventsMenuRepository;

  StreamSubscription<List<EventButtonData>>? _eventsSub;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @visibleForTesting
  void setStartDate(DateTime date) {
    startDate = date;
  }

  @visibleForTesting
  void setEndDate(DateTime date) {
    endDate = date;
  }

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
    CreateEventPopupData? createEventPopup,
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
    _updateState(createEventPopup: CreateEventPopupData.show());
  }

  void showRemoveEventPopup() {
    _updateState(removeEventPopup: const PopupData.show());
  }

  void hidePopup() {
    _updateState(
        createEventPopup: CreateEventPopupData.initial(),
        removeEventPopup: const PopupData.initial());
  }

  Future<bool> createEvent(String name) async {
    if (name.isEmpty) {
      _updateState(
          createEventPopup:
              CreateEventPopupData.error("Deve inserir um nome!"));
      return false;
    }

    if (startDate.compareTo(endDate) > 0) {
      _updateState(
          createEventPopup: CreateEventPopupData.error("Data incorreta!"));
      return false;
    }

    _eventsMenuRepository.createEvent(name, startDate, endDate);
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

  void updateStartDate(DateTime? date) {
    if (date == null) {
      return;
    }
    startDate = date;
    _updateState(createEventPopup: CreateEventPopupData.startDate(date));
  }

  void updateEndDate(DateTime? date) {
    if (date == null) {
      return;
    }
    endDate = date;
    _updateState(createEventPopup: CreateEventPopupData.endDate(date));
  }

  Future<String> getEventDocumentID(String name) async {
    return await _eventsMenuRepository.getEventDocumentID(name);
  }
}
