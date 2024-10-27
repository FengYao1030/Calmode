import 'package:calmode/other/homepage.dart';
import 'package:calmode/screens/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SnackBar _customSnackBar(String message,
      {Color backgroundColor = Colors.black}) {
    return SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    );
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  Future<void> registerWithEmailPassword(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_customSnackBar('Email and password cannot be empty.'));
      return;
    }

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_customSnackBar('Invalid email format.'));
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Create the user account on Firestore
      await _firestore.collection('users').doc(user?.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(_customSnackBar('Registration successful!'));

      // Navigate to the HomePage upon successful registration
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false, // Clear the navigation stack
      );
    } on FirebaseAuthException catch (e) {
      // Log the error for debugging
      // print('Registration Error: ${e.code} - ${e.message}');

      // Immediate navigation for email already in use error
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(_customSnackBar(
            'Email already exists! Redirecting to Sign In page...'));

        // Delay to let the SnackBar show for a brief moment, then navigate
        await Future.delayed(const Duration(seconds: 2));

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignIn()),
          (Route<dynamic> route) => false, // Clear the navigation stack
        );
      } else if (e.code == 'weak-password') {
        // Show SnackBar for weak password
        ScaffoldMessenger.of(context)
            .showSnackBar(_customSnackBar('Weak Password'));
      } else {
        // For any other errors, show the error message
        ScaffoldMessenger.of(context)
            .showSnackBar(_customSnackBar('Registration failed: ${e.message}'));
      }
    }
  }

  Future<bool> signInWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      // Assuming you're using Firebase for authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user is verified
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        return true; // Successful login
      } else {
        return false; // Email not verified
      }
    } catch (e) {
      // Handle specific error codes for better user feedback
      if (e is FirebaseAuthException) {
        // Handle different error types
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          return false; // Invalid credentials
        }
      }
      throw e; // Re-throw unexpected exceptions
    }
  }

/*
  // sign in condition checking
  Future<void> signInWithEmailPassword(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password cannot be empty.')),
      );
      return; // Return if input is empty
    }

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email format.')),
      );
      return; // Return if email format is invalid
    }

    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Display successful login message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Login Successful: ${userCredential.user?.email}')),
      );

      // Navigate to HomePage
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false, // Clear navigation stack
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.message}')),
        );
      }
    } catch (e) {
      // Handle any other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
*/
  void signOutUser() {
    _auth.signOut();
  }
}
