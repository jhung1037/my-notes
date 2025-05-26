import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart' show immutable;
import 'package:mynotes/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class AuthStateUninitialised extends AuthState {
  const AuthStateUninitialised({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({required this.exception, required isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required isLoading})
      : super(isLoading: isLoading);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );

  @override
  List<Object?> get props => [exception, isLoading];
}
