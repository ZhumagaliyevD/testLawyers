import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AlLabibLawyersFirebaseUser {
  AlLabibLawyersFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

AlLabibLawyersFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AlLabibLawyersFirebaseUser> alLabibLawyersFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AlLabibLawyersFirebaseUser>(
            (user) => currentUser = AlLabibLawyersFirebaseUser(user));
