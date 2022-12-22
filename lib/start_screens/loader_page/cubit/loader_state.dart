part of 'loader_cubit.dart';

@immutable
abstract class LoaderState {}

class LoaderInitial extends LoaderState {}

class LoaderAuthenticated extends LoaderState {}

class LoaderUnAuthenticated extends LoaderState {}
