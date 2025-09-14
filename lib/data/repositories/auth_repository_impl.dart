import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({SharedPreferencesAsync? sharedPreferences})
    : _sharedPreferences = sharedPreferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _sharedPreferences;
  final _controller = StreamController<bool?>();

  @override
  Stream<bool?> get isSignedIn => _controller.stream;

  @override
  Future<void> signIn(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    await _sharedPreferences.setString('token', 'token');
    _controller.add(true);
  }

  @override
  Future<void> signOut() async {
    await _sharedPreferences.remove('token');
    _controller.add(false);
  }

  @override
  void dispose() => _controller.close();
}
