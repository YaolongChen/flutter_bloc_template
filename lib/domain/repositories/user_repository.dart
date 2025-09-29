import '../../util/result.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> getUser();
}