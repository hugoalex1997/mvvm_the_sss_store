import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/home/home_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';

@injectable
class HomeViewModel extends ViewModel<HomeData> {
  HomeViewModel() : super(const HomeData.initial());

  void init() {}

  @override
  void dispose() {
    super.dispose();
  }
}
