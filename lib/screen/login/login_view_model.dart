import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/login/login_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';

@injectable
class LoginViewModel extends ViewModel<LoginData> {
  LoginViewModel() : super(const LoginData.initial());
  Future<bool> login(String username, String password) async {
    return true;
  }
}
