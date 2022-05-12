import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:technical_ind/providers/authproviders.dart';

import '../../storage/storageServices.dart';
import '../../styles.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  // AuthResultStatus _authResultStatus;
  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  User get currentUser => _firebaseAuth.currentUser;

  //GOOGLE SIGN IN

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).whenComplete(
          () => BotToast.showText(
              contentColor: almostWhite,
              textStyle: TextStyle(color: black),
              text: "Message Sent Successfully"));
    } on FirebaseAuthException catch (e) {
      BotToast.showText(
          contentColor: almostWhite,
          textStyle: TextStyle(color: black),
          text: e.message);
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        BotToast.showText(
            contentColor: almostWhite,
            textStyle: TextStyle(color: black),
            text: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        BotToast.showText(
            contentColor: almostWhite,
            textStyle: TextStyle(color: black),
            text: 'Wrong password provided for that user.');
      } else {
        BotToast.showText(
            contentColor: almostWhite,
            textStyle: TextStyle(color: black),
            text: e.message);
      }
      // BotToast.showText(contentColor: blue,backgroundColor: Colors.white,contentColor: Colors.black,
      //     text: e.message);
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _firebaseAuth.signInWithCredential(credential);
      StorageService storageService = StorageService(_firebaseAuth.currentUser);

      await storageService.createNewUser();
      return "Signed in With Google";
    } catch (e) {
      BotToast.showText(
          contentColor: almostWhite,
          textStyle: TextStyle(color: black),
          text: e.toString(),
          duration: Duration(seconds: 2));
    }
  }

  Future<void> signOut() async {
    User user = _firebaseAuth.currentUser;
    if (user.providerData.contains('google.com')) {
      print("google sign out");
      await GoogleSignIn().signOut();
    } else
      await _firebaseAuth.signOut();
    // print(user.providerData[1].providerId);
    // if (user.providerData[1].providerId == 'google.com') {
    //   await GoogleSignIn().disconnect();
    // }
    // await _firebaseAuth.signOut();
    // await _firebaseAuth.signOut();
  }

  Future<String> signUp({String email, String password, String name}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firebaseAuth.currentUser.updateProfile(displayName: name);
      print(_firebaseAuth.currentUser);
      await signIn(email: email, password: password);
      StorageService storageService = StorageService(_firebaseAuth.currentUser);
      storageService.createNewUser();
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      BotToast.showText(
          contentColor: almostWhite,
          textStyle: TextStyle(color: black),
          text: e.message,
          duration: Duration(seconds: 2));
      return e.message;
    }
  }
}

Future<String> changePassword(String oldPass, String newPass) async {
  
  User user = FirebaseAuth.instance.currentUser;
  print(user.email + ", " + oldPass + ', ' + newPass);
  try {
    await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: user.email, password: oldPass));
    
    try {
      await user.updatePassword(newPass);
      BotToast.showText(
          contentColor: almostWhite,
          textStyle: TextStyle(color: black),
          text: "Password changed Successfully",
          duration: Duration(seconds: 2));
      return "success";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      BotToast.showText(
          contentColor: almostWhite,
          textStyle: TextStyle(color: black),
          text: e.message,
          duration: Duration(seconds: 2));
      return e.message;
    }
  } on FirebaseAuthException catch (e) {
    print(e.message);
    BotToast.showText(
        contentColor: almostWhite,
        textStyle: TextStyle(color: black),
        text: e.message,
        duration: Duration(seconds: 2));
    return e.message;
  }
}
