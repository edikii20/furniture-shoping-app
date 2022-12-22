part of 'registration_bloc.dart';

enum RegistrationStatus { complete, uncomplete, inprogress }

class RegistrationState {
  final bool isPasswordObscure;
  final RegistrationStatus status;
  final String? error;
  RegistrationState({
    required this.isPasswordObscure,
    required this.status,
    this.error,
  });

  RegistrationState copyWith({
    bool? isPasswordObscure,
    RegistrationStatus? status,
    String? error,
  }) {
    return RegistrationState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  bool operator ==(covariant RegistrationState other) {
    if (identical(this, other)) return true;

    return other.isPasswordObscure == isPasswordObscure &&
        other.status == status &&
        other.error == error;
  }

  @override
  int get hashCode =>
      isPasswordObscure.hashCode ^ status.hashCode ^ error.hashCode;
}
