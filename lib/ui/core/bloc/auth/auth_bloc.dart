import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../../util/result.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       super(AuthUnknown()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<ClearAuthentication>(_onClearAuthentication);
    stream.listen((state) {
      notifier.value = switch (state) {
        AuthUnknown() => null,
        AuthAuthenticated() => true,
        AuthUnauthenticated() => false,
      };
    });
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  final notifier = ValueNotifier<bool?>(null);

  Future<void> _onSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) {
    return emit.onEach(
      _authRepository.isSignedIn,
      onData: (isSignedIn) async {
        switch (isSignedIn) {
          case true:
            final user = await _userRepository.getUser();
            switch (user) {
              case Ok<User>():
                emit(AuthAuthenticated(user: user.value));
              case Error<User>():
                emit(AuthUnauthenticated());
            }
          case false:
            emit(AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onClearAuthentication(
    ClearAuthentication event,
    Emitter<AuthState> emit,
  ) {
    return _authRepository.signOut();
  }

  @override
  Future<void> close() {
    notifier.dispose();
    return super.close();
  }
}
