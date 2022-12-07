import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';

@injectable
class EventsMenuViewModel extends ViewModel<EventsMenuData> {
  EventsMenuViewModel() : super(const EventsMenuData.initial());
}
