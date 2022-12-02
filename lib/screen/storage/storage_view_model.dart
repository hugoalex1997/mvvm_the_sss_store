import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';


@injectable
class StorageViewModel extends ViewModel<StorageData> {
  StorageViewModel() : super(const StorageData.initial());

  void init() {}

  @override
  void dispose() {
    super.dispose();
  }
}
