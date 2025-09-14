abstract class AuthRepository {
  Stream<bool?> get isSignedIn;

  Future<void> signIn(String email, String password);

  Future<void> signOut();

  void dispose();
}
