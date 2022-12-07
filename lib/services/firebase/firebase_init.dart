import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

import 'package:the_sss_store/services/firebase/firebase_options.dart';

@injectable
class FirebaseService {
  static Future<FirebaseService> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseService();
  }
}
