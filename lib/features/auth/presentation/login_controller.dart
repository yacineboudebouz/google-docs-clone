import 'package:docs_clone/features/auth/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AsyncData(null));
  AuthRepository _authRepository;

  void signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signInWithGoogle());
    state = const AsyncData(null);
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
  return LoginController(authRepository: ref.read(authRepositoryProvider));
});
