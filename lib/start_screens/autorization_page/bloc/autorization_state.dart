part of 'autorization_bloc.dart';

@immutable
abstract class AutorizationState {}

class AutorizationEyeVisibilityState extends AutorizationState {
  final bool isObscure = true;
}

class AutorizationUnknownState extends AutorizationState {}

class AutorizationSuccessState extends AutorizationState {}

class AutorizationFailurState extends AutorizationState {
  final String error;

  AutorizationFailurState({required this.error});
}

class AutorizationInProgressState extends AutorizationState {}
