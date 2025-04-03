import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_vending_app/signup_screen.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF121212),
                  Color(0xFF1E1E1E)
                ], // Updated to match dark theme
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Background Shapes
          Positioned(
            top: 100,
            left: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor:
                  Colors.grey.shade800, // Adjusted to match dark theme
            ),
          ),
          Positioned(
            top: 200,
            right: -30,
            child: CircleAvatar(
              radius: 70,
              backgroundColor:
                  Colors.grey.shade700, // Adjusted to match dark theme
            ),
          ),
          Positioned(
            bottom: 100,
            left: 50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor:
                  Colors.grey.shade900, // Adjusted to match dark theme
            ),
          ),
          // Back Arrow and Text
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'Back',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          // Sign Up Form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity, // Fill the width
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), // Rounded top-left corner
                  topRight: Radius.circular(20), // Rounded top-right corner
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple, // Updated to match theme
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Always show label on the border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)), // Increased border radius
                          borderSide: BorderSide(color: Colors.grey, width: 0.5), // Faint border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)), // Increased border radius
                          borderSide: BorderSide(color: Colors.grey, width: 0.5), // Faint border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)), // Increased border radius
                          borderSide: BorderSide(color: Colors.grey, width: 0.5), // Faint border
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Always show label on the border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)), // Increased border radius
                          borderSide: BorderSide(color: Colors.grey, width: 0.5), // Faint border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)), // Increased border radius
                          borderSide: BorderSide(color: Colors.grey, width: 0.5), // Faint border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)), // Increased border radius
                          borderSide: BorderSide(color: Colors.grey, width: 0.5), // Faint border
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            color: Colors.black, // Updated to match theme
                            fontSize: 12,
                          ),
                        ),

                        Text(
                          'Forgot password',
                          style: TextStyle(
                            color: Colors.black, // Updated to match theme
                            fontSize: 12,
                          ),
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.deepPurple, // Updated to match theme
                        foregroundColor: Colors.white,
                      ),
                      child: const Center(child: Text('Sign in')),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Sign in with',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.facebook, color: Colors.blue),
                          const SizedBox(width: 1),
                          const FaIcon(FontAwesomeIcons.twitter,
                              color: Colors.lightBlue),
                          const SizedBox(width: 1),
                          Image.asset(
                            'assets/google.png',
                            width: 24, // Adjust the size as needed
                            height: 24,
                          ),
                          const SizedBox(width: 1),
                          const Icon(Icons.apple, color: Colors.black),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  const SignUpScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0); // Slide in from the right
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account?",
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' Sign up',
                                style: const TextStyle(color: Colors.deepPurple, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
