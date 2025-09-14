import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User> getUser() async {
    return User(id: 'id');
  }
}
