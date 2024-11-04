import 'package:calmode/other/homepage.dart';
import 'package:calmode/other/link.dart';
import 'package:calmode/services/auth_services.dart';
import 'package:calmode/auth/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage; // To hold error messages

  final String imageUrl = Other.logo;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        await _authService.signInWithEmailPassword(
          context,
          _emailController.text,
          _passwordController.text,
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login successful!'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        );

        // Navigate to home page after successful login
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                const HomePage())); // Replace with your profile page
      } catch (error) {
        // Handle error appropriately
        setState(() {
          _errorMessage = "Invalid email or password. Please try again.";
        });

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage ?? 'An error occurred.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8.0), // Adjust the radius for more/less rounding
            ),
            behavior: SnackBarBehavior
                .floating, // Makes the SnackBar float above the content
            margin: const EdgeInsets.all(16), // Adds margin around the SnackBar
          ),
        );

        print("Login failed: $error");
      } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove the back arrow on appbar
        backgroundColor: const Color.fromRGBO(255, 206, 92, 1),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -600,
            left: MediaQuery.of(context).size.width / 2 - 350,
            child: Container(
              width: 700,
              height: 700,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 206, 92, 1),
                  shape: BoxShape.circle),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*const SizedBox(
                  height: 0, // logo above space
                ),*/
                Image.network(
                  imageUrl,
                  height: 80,
                  width: 54,
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Sign In To Calmode',
                  style: TextStyle(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      fontFamily: 'urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 450),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style:
                        const TextStyle(color: Color.fromRGBO(79, 52, 34, 1)),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Color.fromRGBO(237, 126, 28, 1),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUp()));
                          },
                      ),
                    ],
                  ),
                ),
                /*const SizedBox(
                  height: 80,
                ),*/
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 240,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email Address',
                    style: TextStyle(
                        color: Color.fromRGBO(79, 52, 34, 1),
                        fontFamily: 'urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors
                              .white, // set the TextFormField background as white color
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(79, 52, 34,
                                  1), // Normal (unfocused) border color
                              width: 3, // Normal border width
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color.fromRGBO(79, 52, 34, 1),
                            size: 25,
                          ),
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(color: Colors.grey),
                          //focus tetxfield
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(155, 177, 104, 1),
                                width: 3),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                              maxHeight: 40, minWidth: 60)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Password',
                    style: TextStyle(
                        color: Color.fromRGBO(79, 52, 34, 1),
                        fontFamily: 'urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors
                              .white, // set the TextFormField background as white color
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(79, 52, 34,
                                  1), // Normal (unfocused) border color
                              width: 3, // Normal border width
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: Color.fromRGBO(79, 52, 34, 1),
                            size: 25,
                          ),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          //focus tetxfield
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(155, 177, 104, 1),
                                width: 3),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color.fromRGBO(79, 52, 34, 1),
                              ),
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                              maxHeight: 40, minWidth: 60)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: SizedBox(
                      height: 60,
                      width: 350,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
                        ),
                        onPressed: _isLoading ? null : _login,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontFamily: 'urbanist',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ),

                  /*GestureDetector(
                    onTap: _login,
                    child: Container(
                      height: 60,
                      width: 350,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        color: Color.fromRGBO(79, 52, 34, 1),
                      ),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'urbanist'),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),*/

                  /*const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: const TextStyle(color: Color.fromRGBO(79, 52, 34, 1)),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Color.fromRGBO(237, 126, 28, 1),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          /*..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUp()));
                          },*/
                      ),
                    ],
                  ),
                ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
