import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/themes/dimens.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../bloc/login_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = Dimens.of(context);

    return Scaffold(
      body: Padding(
        padding: dimens.screenPadding,
        child: Form(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (BuildContext context, LoginState state) {
              final loading = state is LoginLoading;
              return Column(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      context.read<LoginBloc>().add(LoginEmailChanged(value));
                    },
                    decoration: InputDecoration(
                      labelText: '邮箱',
                      enabled: !loading,
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      context.read<LoginBloc>().add(
                        LoginPasswordChanged(value),
                      );
                    },
                    decoration: InputDecoration(
                      labelText: '密码',
                      enabled: !loading,
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            context.read<LoginBloc>().add(LoginSubmit());
                          },
                    child: loading
                        ? SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text('登录'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
