import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:calmode/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;

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
                Image.asset(
                  'assets/logo.png',
                  height: 80,
                  width: 54,
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Sign Up For Free',
                  style: TextStyle(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      fontFamily: 'urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 450),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account?',
                    style:
                        const TextStyle(color: Color.fromRGBO(79, 52, 34, 1)),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(
                          color: Color.fromRGBO(237, 126, 28, 1),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignIn()));
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
            top: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*const SizedBox(
                  height: 0,
                ),*/
                const Text(
                  'UserName',
                  style: TextStyle(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      fontFamily: 'urbanist',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  height: 60,
                  child: TextField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors
                            .white, // set the textfield background as white color
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
                          Icons.person_outline_sharp,
                          color: Color.fromRGBO(79, 52, 34, 1),
                          size: 25,
                        ),
                        hintText: 'Enter your username',
                        hintStyle: const TextStyle(color: Colors.grey),
                        //focus tetxfield
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(155, 177, 104, 1),
                              width: 3),
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(maxHeight: 40, minWidth: 60)),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Email Address',
                  style: TextStyle(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      fontFamily: 'urbanist',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  height: 60,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors
                            .white, // set the textfield background as white color
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
                        prefixIconConstraints:
                            const BoxConstraints(maxHeight: 40, minWidth: 60)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      fontFamily: 'urbanist',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  height: 60,
                  child: TextField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors
                            .white, // set the textfield background as white color
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
                        prefixIconConstraints:
                            const BoxConstraints(maxHeight: 40, minWidth: 60)),
                  ),
                ),
                const SizedBox(height: 35),
                Container(
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
        ],
      ),
    );
  }
}
