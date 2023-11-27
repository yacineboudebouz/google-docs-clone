import 'package:docs_clone/core/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(googleSignIn: ref.read(googleSignInProvider)));

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  AuthRepository({required GoogleSignIn googleSignIn})
      : _googleSignIn = googleSignIn;

  Future signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        print(user.email);
        print(user.displayName);
      }
    } catch (e) {
      throw e;
    }
  }
}
