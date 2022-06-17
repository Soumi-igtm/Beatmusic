import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static UserService instance = UserService();

  String authenticate() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser == null ? "" : auth.currentUser!.uid;
  }
}
