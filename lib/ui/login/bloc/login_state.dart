sealed class LoginState {
  const LoginState({this.email = '', this.password = ''});

  final String email;
  final String password;
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.email, super.password});
}

final class LoginLoading extends LoginState {
  const LoginLoading({required super.email, required super.password});
}

final class LoginSuccess extends LoginState {
  const LoginSuccess({required super.email, required super.password});
}

final class LoginFailure extends LoginState {
  const LoginFailure({
    required super.email,
    required super.password,
    this.error = '',
  });

  final String error;
}
