import 'dart:math';

import 'package:furniture_shoping_app/domain/hive_db/data_provider/box_manager.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/session.dart';
import 'package:hive/hive.dart';

import '../hive_db/entities/user.dart';

enum ExceptionCodes {
  invalidEmail,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  passwordsNotSame,
  weakPassword
}

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

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(ExceptionCodes code) {
    switch (code) {
      case ExceptionCodes.invalidEmail:
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case ExceptionCodes.emailAlreadyInUse:
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case ExceptionCodes.passwordsNotSame:
        return const SignUpWithEmailAndPasswordFailure(
          'Password and Confirm Password is not same.',
        );
      case ExceptionCodes.weakPassword:
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class AuthorisationRepository {
  late final Future<Box<User>> _usersBox;
  late final Future<Box<Session>> _sessionBox;
  final RegExp _emailRegExp =
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  final _passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  AuthorisationRepository() {
    _init();
  }

  Future<void> _init() async {
    _sessionBox = BoxManager.instance.openSessionBox();
    _usersBox = BoxManager.instance.openUsersBox();
  }

  Future<void> _closeBoxes() async {
    BoxManager.instance.closeBox(await _usersBox);
    BoxManager.instance.closeBox(await _sessionBox);
  }

  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!_emailRegExp.hasMatch(email)) {
      throw LogInWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.invalidEmail);
    } else if (!(await _usersBox)
        .values
        .any((element) => element.email == email)) {
      throw LogInWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.userNotFound);
    } else {
      final user = (await _usersBox)
          .values
          .where((element) => element.email == email)
          .first;

      if (user.password != password) {
        throw LogInWithEmailAndPasswordFailure.fromCode(
            ExceptionCodes.wrongPassword);
      }
      await (await _sessionBox).add(
        Session(
          token: '${Random().nextInt(8999999) + 1000000}',
          user: HiveList(await _usersBox, objects: [user]),
        ),
      );
      _closeBoxes();
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (password != confirmPassword) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.passwordsNotSame);
    } else if (!_emailRegExp.hasMatch(email)) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.invalidEmail);
    } else if (!_passwordRegExp.hasMatch(password)) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.weakPassword);
    } else if ((await _usersBox).values.any((user) => user.email == email)) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(
          ExceptionCodes.emailAlreadyInUse);
    } else {
      final catalogBox = await BoxManager.instance.openHomeCatalogBox();
      await (await _usersBox).add(User(
        name: name,
        email: email,
        password: password,
        image: 'image',
        cartList: [],
        favoriteList: HiveList(catalogBox, objects: []),
      ));
      BoxManager.instance.closeBox(catalogBox);
      _closeBoxes();
    }
  }

  Future<void> logout() async {
    await (await _sessionBox).deleteAt(0);
    _closeBoxes();
  }

  Future<bool> checkAuth() async {
    final authenticated = (await _sessionBox).isNotEmpty;
    _closeBoxes();
    await Future.delayed(const Duration(seconds: 3));
    return authenticated;
  }
}
