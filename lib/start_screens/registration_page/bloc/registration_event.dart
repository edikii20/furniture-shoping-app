part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent {}

class RegistrationSignUpEvent extends RegistrationEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  RegistrationSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class RegistrationOnPressEyeEvent extends RegistrationEvent {}
