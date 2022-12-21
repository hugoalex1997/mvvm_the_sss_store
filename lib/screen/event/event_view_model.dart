import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

import 'package:the_sss_store/screen/event/event_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';
import 'package:the_sss_store/repository/event_repository.dart';
import 'package:the_sss_store/model/event.dart';
import 'package:the_sss_store/common/data/item_data.dart';
import 'package:the_sss_store/common/utils.dart';

@injectable
class EventViewModel extends ViewModel<EventData> {
  EventViewModel(this._eventRepository) : super(const EventData.initial());

  final EventRepository _eventRepository;

  String documentID = "";
  Event? eventData;

  void init(String documentID) async {
    _updateState(isLoading: true);

    this.documentID = documentID;
    await fetchEventData();

    _updateState(isLoading: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchEventData() async {
    Event event = await _eventRepository.fetchEventData(documentID);
    _updateState(
        name: event.name,
        startDate: Utils.dateToString(event.startDate),
        endDate: Utils.dateToString(event.endDate));
  }

  void _updateState({
    bool? isLoading,
    String? name,
    String? startDate,
    String? endDate,
    List<ItemData>? itemData,
    PopupData? addItemPopup,
    PopupData? removeItemPopup,
    PopupData? changeEventPopup,
  }) {
    isLoading ??= value.showLoading;
    name ??= value.name;
    startDate ??= value.startDate;
    endDate ??= value.endDate;
    itemData ??= value.itemData;
    addItemPopup ??= value.addItemPopup;
    removeItemPopup ??= value.removeItemPopup;
    changeEventPopup ??= value.changeEventPopup;

    stateData = EventData(
        showEmptyState: name.isEmpty && !isLoading,
        showLoading: isLoading,
        name: name,
        startDate: startDate,
        endDate: endDate,
        itemData: itemData,
        addItemPopup: addItemPopup,
        removeItemPopup: removeItemPopup,
        changeEventPopup: changeEventPopup);
  }

  void showAddItemPopup() {
    _updateState(addItemPopup: const PopupData.show());
  }

  void showRemoveItemPopup() {
    _updateState(removeItemPopup: const PopupData.show());
  }

  void showChangeEventPopup() {
    _updateState(changeEventPopup: const PopupData.show());
  }

  void hidePopup() {
    _updateState(
        addItemPopup: const PopupData.initial(),
        removeItemPopup: const PopupData.initial(),
        changeEventPopup: const PopupData.initial());
  }
}
