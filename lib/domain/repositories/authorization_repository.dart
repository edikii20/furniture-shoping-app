import 'package:furniture_shoping_app/domain/hive_db/data_provider/box_manager.dart';
import 'package:hive/hive.dart';

import '../hive_db/entities/user.dart';

enum ExceptionCodes { invalidEmail, userNotFound, wrongPassword }

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(ExceptionCodes code) {
    switch (code) {
      case ExceptionCodes.invalidEmail:
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );

      case ExceptionCodes.userNotFound:
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case ExceptionCodes.wrongPassword:
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

class AuthorisationRepository {
  late final Box<User> _usersBox;
  late final Box<User> _sessionBox;
  final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  AuthorisationRepository() {
    _init();
  }

  Future<void> _init() async {
    _sessionBox = await BoxManager.instance.openSessionBox();
    _usersBox = await BoxManager.instance.openUsersBox();
  }

  void _closeBoxes() {
    BoxManager.instance.closeBox(_usersBox);
    BoxManager.instance.closeBox(_sessionBox);
  }

  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!_emailRegExp.hasMatch(email)) {
      throw LogInWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.invalidEmail);
    } else if (!_usersBox.values.any((element) => element.email == email)) {
      throw LogInWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.userNotFound);
    } else {
      //TODO: Переделать с user id
      final user =
          _usersBox.values.where((element) => element.email == email).first;
      if (user.password != password) {
        throw LogInWithEmailAndPasswordFailure.fromCode(
            ExceptionCodes.wrongPassword);
      }
      await _sessionBox.add(user);
      _closeBoxes();
    }
  }
}
