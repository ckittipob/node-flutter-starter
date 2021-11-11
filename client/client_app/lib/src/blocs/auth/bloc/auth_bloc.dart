import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:client_app/src/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // Check Auth
    if (event is CheckAuth) {
      // read token from storage
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('userData')) {
        final extracted =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        yield AuthLoaded(extracted['token']);
      } else {
        yield AuthUnAuth();
      }
      // Login
    } else if (event is Login) {
      try {
        yield AuthLoading();
        final jwt = await _authRepository.login(event.username, event.password);

        // save token to storage
        final prefs = await SharedPreferences.getInstance();
        if (jwt != null) {
          final userData = json.encode({'token': jwt});
          prefs.setString('userData', userData);
          yield AuthLoaded(jwt);
        } else {
          yield AuthUnAuth();
        }
      } on Exception {
        yield AuthUnAuth();
        print('login error');
      }
      // Logout
    } else if (event is Logout) {
      // remove token from storage
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');

      yield AuthUnAuth();
    }
  }

  // implement logout event
}
