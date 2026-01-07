import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount? googleUser;

    if (kIsWeb) {
      // Web: il faut préciser le clientId
      googleUser = await GoogleSignIn(
        clientId: "117460258962-k32b7n56d8jnn9t870vvarjftu8qf6rq.apps.googleusercontent.com", // <== ton client ID Web ici
      ).signIn();
    } else {
      // Android/iOS
      googleUser = await GoogleSignIn().signIn();
    }

    if (googleUser == null) {
      throw Exception('Connexion annulée');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }
}
