import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc_template/domain/repositories/user_repository.dart';
import 'package:flutter_bloc_template/ui/core/bloc/auth/auth_event.dart';
import 'package:flutter_bloc_template/ui/core/bloc/auth/auth_state.dart';

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
            try {
              final user = await _userRepository.getUser();
              emit(AuthAuthenticated(user: user));
            } catch (_) {
              emit(AuthUnauthenticated());
            }
          case false:
            emit(AuthUnauthenticated());
          case null:
            emit(AuthUnknown());
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
