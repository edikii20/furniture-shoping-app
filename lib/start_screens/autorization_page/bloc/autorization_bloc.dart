import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'autorization_event.dart';
part 'autorization_state.dart';

class AutorizationBloc extends Bloc<AutorizationEvent, AutorizationState> {
  AutorizationBloc() : super(AutorizationUnknownState()) {
    on<AutorizationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
