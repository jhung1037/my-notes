import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;
import 'constants/routes.dart';
import 'view/login_view.dart';
import 'view/notes_view.dart';
import 'view/register_view.dart';
import 'view/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'My Notes',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NoteView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user == null) return const LoginView();
              if (!user.isEmailVerified) return const VerifyEmailView();
              devtools.log('email verified');
              return const Text('Done');
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
