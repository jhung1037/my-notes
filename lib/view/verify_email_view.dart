import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text('Email verification sent'),
          TextButton(
              // onPressed: () async {
              //   final user = AuthService.firebase().currentUser;
              //   devtools.log(user.toString());
              //   // can't resend when just registered -> check if resolved
              //   await AuthService.firebase().sendEmailVerification();
              // },
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventSendEmailVerification(),
                    );
              },
              child: const Text('Resend email verification')),
          TextButton(
              // onPressed: () async {
              //   await AuthService.firebase().logOut();
              //   Navigator.of(context)
              //       .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              // },
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: const Text('Return to registration'))
        ],
      ),
    );
  }
}
