import '../../util/result.dart';

abstract class AuthRepository {
  Stream<bool> get isSignedIn;

  Future<Result<void>> signIn(String email, String password);

  Future<Result<void>> signOut();

  void dispose();
}
