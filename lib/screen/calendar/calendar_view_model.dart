import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/calendar/calendar_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';

@injectable
class CalendarViewModel extends ViewModel<CalendarData> {
  CalendarViewModel() : super(const CalendarData.initial());
}
