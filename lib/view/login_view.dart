import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
// import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/loading_dialogs.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  // CloseDialog? _closeDialogHandle;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          // final closeDialog = _closeDialogHandle;

          // if (!state.isLoading && closeDialog != null) {
          //   closeDialog();
          //   _closeDialogHandle = null;
          // } else if (state.isLoading && closeDialog != null) {
          //   _closeDialogHandle =
          //       showLoadingDialog(context: context, text: "Loading...");
          // }
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_cannot_find_user,
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_wrong_credentials,
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_auth_error,
            );
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(hintText: 'Enter your email here'),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration:
                      const InputDecoration(hintText: 'Enter your password here'),
                ),
                // BlocListener<AuthBloc, AuthState>(
                //   listener: (context, state) async {
                //     if (state is AuthStateLoggedOut) {
                //       if (state.exception is UserNotFoundAuthException) {
                //         await showErrorDialog(
                //           context,
                //           context.loc.login_error_cannot_find_user,
                //         );
                //       } else if (state.exception is WrongPasswordAuthException) {
                //         await showErrorDialog(
                //           context,
                //           context.loc.login_error_wrong_credentials,
                //         );
                //       } else if (state.exception is GenericAuthException) {
                //         await showErrorDialog(
                //           context,
                //           context.loc.login_error_auth_error,
                //         );
                //       }
                //     }
                //   },
                // ),
                TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context.read<AuthBloc>().add(AuthEventLogIn(
                          email,
                          password,
                        ));
                    // try {
                    //   // await AuthService.firebase()
                    //   //     .logIn(email: email, password: password);
                    //   // final user = AuthService.firebase().currentUser;
                    //   // devtools.log(user.toString());
                    //   // if (user?.isEmailVerified == true) {
                    //   //   Navigator.of(context)
                    //   //       .pushNamedAndRemoveUntil(notesRoute, (_) => false);
                    //   // } else {
                    //   //   Navigator.of(context).pushNamed(verifyEmailRoute);
                    //   // }
                    //   context.read<AuthBloc>().add(AuthEventLogIn(
                    //         email,
                    //         password,
                    //       ));
                    // } on UserNotFoundAuthException {
                    //   await showErrorDialog(context, 'User not found');
                    // } on WrongPasswordAuthException {
                    //   await showErrorDialog(context, 'Wrong password');
                    // } on GenericAuthException {
                    //   await showErrorDialog(context, 'Authentication error');
                    // }
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(),
                        );
                  },
                  child: Text(
                    context.loc.login_view_forgot_password,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const AuthEventShouldRegister());
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     registerRoute, (route) => false);
                    },
                    child: const Text('Not registered yet? Register here!'))
              ],
            ),
          )),
    );
  }
}
