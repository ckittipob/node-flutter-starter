part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthUnAuth extends AuthState {
  const AuthUnAuth();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoaded extends AuthState with EquatableMixin {
  final String token;
  const AuthLoaded(this.token);

  @override
  List<Object> get props => [token];
}
