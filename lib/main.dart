import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'router/router.dart';
import 'ui/core/bloc/auth/auth_bloc.dart';
import 'ui/core/bloc/auth/auth_event.dart';
import 'ui/core/themes/theme.dart';
import 'ui/login/bloc/login_bloc.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl() as AuthRepository,
          dispose: (authRepository) => authRepository.dispose(),
        ),
        RepositoryProvider(
          create: (context) => UserRepositoryImpl() as UserRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => AuthBloc(
              authRepository: context.read(),
              userRepository: context.read(),
            )..add(AuthSubscriptionRequested()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(authRepository: context.read()),
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> with RouterMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
