import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/services/database_func.dart';
import 'package:todo_app/utils/constants.dart';

Future<String> resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return "Success";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      return 'Invalid Email. Please provide correct email';
    } else if (e.code == 'user-not-found') {
      return 'Email not found. Consider signing up first';
    } else {
      return e.code;
    }
  }
}

Future<void> signout() async {
  await FirebaseAuth.instance.signOut();
}

Future<String> signup(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    String res = await saveData(email);
    return res;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'Password is too weak';
    } else if (e.code == 'email-already-in-use') {
      return 'This Email is already registered, Go to login page.';
    } else {
      return e.code;
    }
  }
}

Future<String> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return MyConstants.loginSuccess;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    } else {
      return e.code;
    }
  }
}
