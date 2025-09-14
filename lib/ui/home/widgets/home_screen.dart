import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/auth/auth_bloc.dart';
import '../../core/bloc/auth/auth_event.dart';
import '../../core/themes/dimens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = Dimens.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: dimens.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            Text('Home'),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(ClearAuthentication());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
