import '../../../../domain/entities/user.dart';

sealed class AuthState {}

final class AuthUnknown extends AuthState {}

final class AuthAuthenticated extends AuthState {
  AuthAuthenticated({required this.user});

  final User user;
}

final class AuthUnauthenticated extends AuthState {}
