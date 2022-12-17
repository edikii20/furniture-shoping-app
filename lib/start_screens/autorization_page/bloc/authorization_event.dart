part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationEvent {}

class AuthorizationLogInEvent extends AuthorizationEvent {
  final String email;
  final String password;

  AuthorizationLogInEvent({
    required this.email,
    required this.password,
  });
}

class AuthorizationOnPressEyeEvent extends AuthorizationEvent {}
