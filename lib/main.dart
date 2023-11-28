import 'package:docs_clone/core/providers/local_storage_provider.dart';
import 'package:docs_clone/features/auth/domain/user.dart';
import 'package:docs_clone/features/auth/presentation/login_controller.dart';
import 'package:docs_clone/routing/route_master.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      localStorageProvider.overrideWithValue(LocalStorage(prefs)),
    ],
  );
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  void getUserData(WidgetRef ref) {
    ref.watch(loginControllerProvider.notifier).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    getUserData(ref);

    return MaterialApp.router(
      title: 'Flutter Demo',
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        print(ref.watch(userStateProvider));
        return ref.watch(userStateProvider) == null
            ? loggedOutRoute
            : loggedInRoute;
      }),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
