import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/User.dart';
import '../Model/userLogin.dart';
import '../repository/authentication_repository.dart';

// Eventos
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}

// Estados
abstract class AuthenticationState {}

class InitialState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final User userDetails;
  final UserLogin user;

  AuthenticatedState({required this.user, required this.userDetails});
}

class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError({required this.error});
}

// BloC
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  AuthenticationBloc() : super(InitialState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      try {
        final user = await authenticationRepository.login(
            event.username, event.password);
        final userDetails =
            await authenticationRepository.getUserDetails(event.username);

        yield AuthenticatedState(user: user, userDetails: userDetails);
      } catch (e) {
        yield AuthenticationError(
            error: 'Failed to authenticate. Please try again.');
      }
    }
  }
}
