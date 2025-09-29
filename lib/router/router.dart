import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../ui/core/bloc/auth/auth_bloc.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/login/widgets/login_screen.dart';
import '../ui/splash/widgets/splash_screen.dart';
import 'routes.dart';

mixin RouterMixin on State<MainApp> {
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthBloc>();
    router = GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: authBloc.notifier,
      initialLocation: Routes.splash,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) {
            return SplashScreen();
          },
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) {
            return LoginScreen();
          },
        ),
        GoRoute(
          path: Routes.home,
          builder: (context, state) {
            return HomeScreen();
          },
        ),
      ],
      redirect: (context, state) async {
        final authenticated = authBloc.notifier.value;
        final isLoginScreen = state.uri.path == Routes.login;
        final isSplashScreen = state.uri.path == Routes.splash;

        if (authenticated == false) {
          return isLoginScreen ? null : Routes.login;
        }

        if (authenticated == true && (isSplashScreen || isLoginScreen)) {
          return Routes.home;
        }

        return null;
      },
    );
  }
}
