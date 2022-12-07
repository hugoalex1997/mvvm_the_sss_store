import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/event/event_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';

@injectable
class EventViewModel extends ViewModel<EventData> {
  EventViewModel() : super(const EventData.initial());

  void init() {}

  @override
  void dispose() {
    super.dispose();
  }
}
