part of 'autorization_bloc.dart';

@immutable
abstract class AutorizationEvent {}

class AutorizationLogInEvent extends AutorizationEvent {
  final String email;
  final String password;

  AutorizationLogInEvent({
    required this.email,
    required this.password,
  });
}

class AutorizationOnPressEyeEvent extends AutorizationEvent {
  final bool isObscure;

  AutorizationOnPressEyeEvent({
    required this.isObscure,
  });
}
