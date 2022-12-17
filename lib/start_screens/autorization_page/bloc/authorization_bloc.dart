import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/authorization_repository.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final authorizationRepository = AuthorisationRepository();
  AuthorizationBloc()
      : super(AuthorizationState(
            isPasswordObscure: true,
            status: AuthorizationStatus.unauthenticated,
            error: null)) {
    on<AuthorizationEvent>((event, emit) async {
      if (event is AuthorizationLogInEvent) {
        emit(state.copyWith(
            status: AuthorizationStatus.inprogress, error: null));
        await _onLogInRequested(
          email: event.email,
          password: event.password,
          emit: emit,
        );
      } else if (event is AuthorizationOnPressEyeEvent) {
        emit(state.copyWith(
            isPasswordObscure: !state.isPasswordObscure, error: null));
      }
    });
  }

  Future<void> _onLogInRequested({
    required String email,
    required String password,
    required Emitter<AuthorizationState> emit,
  }) async {
    try {
      await authorizationRepository.login(email: email, password: password);
      emit(state.copyWith(
          status: AuthorizationStatus.authenticated, error: null));
    } on LogInWithEmailAndPasswordFailure catch (error) {
      emit(state.copyWith(
          status: AuthorizationStatus.unauthenticated, error: error.message));
    }
  }
}
