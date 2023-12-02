import 'dart:convert';

import 'package:docs_clone/core/providers/auth_providers.dart';
import 'package:docs_clone/core/providers/local_storage_provider.dart';
import 'package:docs_clone/core/providers/uri_provider.dart';
import 'package:docs_clone/features/auth/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) =>
      AuthRepository(googleSignIn: ref.read(googleSignInProvider), ref: ref),
);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Ref _ref;
  AuthRepository({required GoogleSignIn googleSignIn, required Ref ref})
      : _googleSignIn = googleSignIn,
        _ref = ref;

  Future signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
          email: user.email,
          name: user.displayName!,
          profilePic: user.photoUrl!,
          uid: "",
          token: "",
        );

        http.Response res = await http.post(Uri.parse('$uri/auth/signup'),
            body: userAcc.toJson(),
            headers: {'Content-Type': 'application/json; charset=UTF-8'});
        if (res.statusCode == 201 || res.statusCode == 200) {
          _ref.watch(userStateProvider.notifier).update(
                (state) => userAcc.copyWith(
                  uid: jsonDecode(res.body)['user']['_id'],
                  token: jsonDecode(res.body)['token'],
                ),
              );
          _ref
              .read(localStorageProvider)
              .storeToken(jsonDecode(res.body)['token']);
        }

        if (res.statusCode == 500) {
          throw Exception(json.decode(res.body));
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getUserData() async {
    try {
      final token = _ref.read(localStorageProvider).getToken();

      if (token == null) {
        return;
      }
      http.Response res = await http.get(Uri.parse('$uri/auth'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      });

      if (res.statusCode == 200) {
        _ref
            .read(userStateProvider.notifier)
            .update((state) => UserModel.fromJson(res.body));
      }
      if (res.statusCode == 401) {
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future logOut() async {
    try {
      await _ref.read(localStorageProvider).removeToken();
      _ref.read(userStateProvider.notifier).update((state) => null);
      await _googleSignIn.signOut();
    } catch (e) {
      throw e;
    }
  }
}
