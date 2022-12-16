import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/authorization_repository.dart';

part 'autorization_event.dart';
part 'autorization_state.dart';

//TODO: Подумать над переработкай стейта и разделить его на разные
class AutorizationBloc extends Bloc<AutorizationEvent, AuthorizationState> {
  final authorizationRepository = AuthorisationRepository();
  AutorizationBloc()
      : super(AuthorizationState(
            isPasswordObscure: true,
            status: AuthorizationStatus.unauthenticated)) {
    on<AutorizationEvent>((event, emit) {
      if (event is AutorizationLogInEvent) {
        _onLogInRequested(
          email: event.email,
          password: event.password,
          emit: emit,
        );
      } else if (event is AutorizationOnPressEyeEvent) {
        emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
      }
    });
  }

  Future<void> _onLogInRequested({
    required String email,
    required String password,
    required Emitter<AuthorizationState> emit,
  }) async {
    try {
      print('$email   $password');
      emit(state.copyWith(status: AuthorizationStatus.inprogress));
      await authorizationRepository.login(email: email, password: password);
      emit(state.copyWith(status: AuthorizationStatus.authenticated));
    } on LogInWithEmailAndPasswordFailure catch (error) {
      emit(state.copyWith(
          status: AuthorizationStatus.unauthenticated, error: error.message));
    }
  }
}
