import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../util/result.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(LoginInitial()) {
    on<LoginSubmit>(_onLoginSubmitted);
    on<LoginEmailChanged>((event, emit) {
      emit(LoginInitial(email: event.email, password: state.password));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(LoginInitial(email: state.email, password: event.password));
    });
  }

  final AuthRepository _authRepository;

  void _onLoginSubmitted(LoginSubmit event, Emitter<LoginState> emit) async {
    emit(LoginLoading(email: state.email, password: state.password));
    final signIn = await _authRepository.signIn(state.email, state.password);
    switch (signIn) {
      case Ok<void>():
        emit(LoginSuccess(email: state.email, password: state.password));
        break;
      case Error<void>():
        emit(
          LoginFailure(
            email: state.email,
            password: state.password,
            error: signIn.error.toString(),
          ),
        );
        break;
    }
  }
}
