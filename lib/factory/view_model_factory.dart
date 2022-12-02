import 'package:injectable/injectable.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/view_model/view_model.dart';

abstract class ViewModelFactory {
  T create<T extends ViewModel>();
}

@Singleton(as: ViewModelFactory)
class ViewModelFactoryImpl implements ViewModelFactory {
  @override
  T create<T extends ViewModel>() => getIt.get<T>();
}
