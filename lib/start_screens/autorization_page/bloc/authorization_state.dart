part of 'authorization_bloc.dart';

enum AuthorizationStatus { authenticated, unauthenticated, inprogress }

class AuthorizationState {
  final bool isPasswordObscure;
  final AuthorizationStatus status;
  final String? error;
  AuthorizationState({
    required this.isPasswordObscure,
    required this.status,
    this.error,
  });

  AuthorizationState copyWith({
    bool? isPasswordObscure,
    AuthorizationStatus? status,
    String? error,
  }) {
    return AuthorizationState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  bool operator ==(covariant AuthorizationState other) {
    if (identical(this, other)) return true;

    return other.isPasswordObscure == isPasswordObscure &&
        other.status == status &&
        other.error == error;
  }

  @override
  int get hashCode =>
      isPasswordObscure.hashCode ^ status.hashCode ^ error.hashCode;
}
