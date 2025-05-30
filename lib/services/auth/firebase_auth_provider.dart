import "package:firebase_auth/firebase_auth.dart"
    show FirebaseAuth, FirebaseAuthException;
import "package:firebase_core/firebase_core.dart";
import "package:mynotes/firebase_options.dart";
import "package:mynotes/services/auth/auth_exception.dart";
import "package:mynotes/services/auth/auth_provider.dart";
import "package:mynotes/services/auth/auth_user.dart";

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user == null) throw UserNotLoggedInAuthException();
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw WeakPasswordAuthException();
        case 'email-already-in-use':
          throw EmailAlreadyInUseAuthException();
        case 'invalid-email':
          throw InvalidEmailAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) return AuthUser.fromFirebase(user);
    return null;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      // await Future.delayed (const Duration (seconds: 3));
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user == null) throw UserNotFoundAuthException();
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case ('user-not-found'):
          throw UserNotFoundAuthException();
        case ('wrong-password'):
          throw WrongPasswordAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw UserNotLoggedInAuthException();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw UserNotLoggedInAuthException();
    await user.sendEmailVerification();
  }
  
  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
