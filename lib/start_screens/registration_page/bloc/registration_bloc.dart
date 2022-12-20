import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/authorization_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final authorizationRepository = AuthorisationRepository();
  RegistrationBloc()
      : super(RegistrationState(
          isPasswordObscure: true,
          status: RegistrationStatus.uncomplete,
          error: null,
        )) {
    on<RegistrationEvent>((event, emit) async {
      if (event is RegistrationSignUpEvent) {
        emit(
            state.copyWith(status: RegistrationStatus.inprogress, error: null));
        await _onSignUpRequested(
          name: event.name,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
          emit: emit,
        );
      } else if (event is RegistrationOnPressEyeEvent) {
        emit(state.copyWith(
            isPasswordObscure: !state.isPasswordObscure, error: null));
      }
    });
  }

  Future<void> _onSignUpRequested({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required Emitter<RegistrationState> emit,
  }) async {
    try {
      await authorizationRepository.signup(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword);
      emit(state.copyWith(status: RegistrationStatus.complete, error: null));
    } on SignUpWithEmailAndPasswordFailure catch (error) {
      emit(state.copyWith(
          status: RegistrationStatus.uncomplete, error: error.message));
    }
  }
}
