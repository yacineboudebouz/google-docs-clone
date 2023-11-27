import 'package:docs_clone/core/utils.dart';
import 'package:docs_clone/features/auth/presentation/login_controller.dart';
import 'package:docs_clone/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(loginControllerProvider.select((state) => state),
        (_, state) {
      if (state.hasError) {
        showSnackBar(context, state.error.toString(), Colors.red);
      }
    });
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            ref.read(loginControllerProvider.notifier).signInWithGoogle();
          },
          icon: Image.asset(
            'assets/g-logo-2.png',
            height: 20,
          ),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(
              color: kBlackColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kWhiteColor,
            minimumSize: const Size(150, 50),
          ),
        ),
      ),
    );
  }
}
