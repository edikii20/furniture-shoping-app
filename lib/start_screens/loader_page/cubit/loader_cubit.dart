import 'package:bloc/bloc.dart';
import 'package:furniture_shoping_app/domain/repositories/authorization_repository.dart';
import 'package:meta/meta.dart';

part 'loader_state.dart';

class LoaderCubit extends Cubit<LoaderState> {
  final authorizationRepositori = AuthorisationRepository();
  LoaderCubit() : super(LoaderInitial());

  Future<void> checkAuth() async {
    if (await authorizationRepositori.checkAuth()) {
      emit(LoaderAuthenticated());
    } else {
      emit(LoaderUnAuthenticated());
    }
  }
}
