import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../util/result.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Result<User>> getUser() async {
    try {
      return Result.ok(User(id: 'id'));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
