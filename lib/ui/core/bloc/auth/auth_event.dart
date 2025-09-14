sealed class AuthEvent {}

final class AuthSubscriptionRequested extends AuthEvent {}

final class ClearAuthentication extends AuthEvent {}
