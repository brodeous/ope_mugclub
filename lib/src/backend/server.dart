import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Server {
  static DatabaseReference database =
      FirebaseDatabase.instance.ref('memberData/');
}
