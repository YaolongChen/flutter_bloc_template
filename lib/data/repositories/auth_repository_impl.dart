import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../util/result.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({SharedPreferencesAsync? sharedPreferences})
    : _sharedPreferences = sharedPreferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _sharedPreferences;
  final _controller = StreamController<bool>();

  @override
  Stream<bool> get isSignedIn async* {
    await Future.delayed(Duration(seconds: 1));
    yield true;
    yield* _controller.stream;
  }

  @override
  Future<Result<void>> signIn(String email, String password) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      await _sharedPreferences.setString('token', 'token');
      _controller.add(true);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _sharedPreferences.remove('token');
      _controller.add(false);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  void dispose() => _controller.close();
}
