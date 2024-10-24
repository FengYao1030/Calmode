/*import 'package:calmode/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // initialize register and Login function with authService
  // pass parameter (email & password) into the function
  Future<void> _register() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    await _authService.registerWithEmailPassword(
      context,
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false; // Stop loading
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    await _authService.signInWithEmailPassword(
      context,
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_isLoading) // Show loading indicator if loading
              const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : _register, // Disable button while loading
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : _login, // Disable button while loading
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/