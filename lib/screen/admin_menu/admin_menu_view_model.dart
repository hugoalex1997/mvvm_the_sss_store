import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/admin_menu/admin_menu_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';

@injectable
class AdminMenuViewModel extends ViewModel<AdminMenuData> {
  AdminMenuViewModel(
  ) : super(const AdminMenuData.initial());

}
