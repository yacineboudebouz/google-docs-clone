import 'package:docs_clone/features/auth/presentation/login_screen.dart';
import 'package:docs_clone/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {'/': (_) => const MaterialPage(child: LoginScreen())},
);

final loggedInRoute =
    RouteMap(routes: {'/': (_) => const MaterialPage(child: HomeScreen())});
