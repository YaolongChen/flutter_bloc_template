import 'package:go_router/go_router.dart';

import 'routes.dart';
import '../ui/core/bloc/auth/auth_bloc.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/login/widgets/login_screen.dart';

GoRouter router(AuthBloc authBloc) => GoRouter(
  debugLogDiagnostics: true,
  refreshListenable: authBloc.notifier,
  initialLocation: Routes.login,
  routes: [
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

    if (authenticated == false) {
      return isLoginScreen ? null : Routes.login;
    }

    if (isLoginScreen) {
      return Routes.home;
    }

    return null;
  },
);
