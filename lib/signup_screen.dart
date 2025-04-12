import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_vending_app/signin_screen.dart';
import 'package:mobile_vending_app/api_repository.dart';
import 'package:mobile_vending_app/email_verification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ApiRepository _apiRepository =
      ApiRepository(); // Initialize the API repository
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _agreeToTerms = false; // State variable for the checkbox

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _apiRepository.registerUser(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
          phone: _phoneController.text,
          username: _usernameController.text,
        );

        // Check if the response contains success information
        if (response.containsKey('success') && response['success'] == true) {
          // Debugging: Print the response
          print('Registration Successful: $response');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Registration successful, please check email to confirm.'),
            ),
          );

          // Navigate to the EmailVerificationPage with the email
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EmailVerificationPage(email: _emailController.text),
            ),
          );
        } else {
          // Handle unsuccessful registration
          final errorMessage =
              response['message'] ?? 'Registration failed. Please try again.';
          print('Registration Failed: $response');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $errorMessage')),
          );
        }
      } catch (e) {
        // Debugging: Print the error
        print('Registration Error: $e');

        // Display detailed error message in the UI
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
              margin: const EdgeInsets.only(top: 75), // Move the form down
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple, // Updated to match theme
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Add more space below "Get Started"
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter your full name',
                          hintStyle: TextStyle(
                              color: Colors.black26), // More faint placeholder
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // Always show label on the border
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12), // Reduced height
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color:
                                Colors.black), // Ensure entered text is black
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                              color: Colors.black26), // More faint placeholder
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // Always show label on the border
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12), // Reduced height
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color:
                                Colors.black), // Ensure entered text is black
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(
                              color: Colors.black38), // Faint placeholder
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // Always show label on the border
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.5), // Faint border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.5), // Faint border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.5), // Faint border
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color:
                                Colors.black), // Ensure entered text is black
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(
                              color: Colors.black38), // Faint placeholder
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // Always show label on the border
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.5), // Faint border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.5), // Faint border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)), // Increased border radius
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.5), // Faint border
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color:
                                Colors.black), // Ensure entered text is black
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.black),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                              color: Colors.black26), // More faint placeholder
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12), // Reduced height
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2), // More faint border
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color:
                                Colors.black), // Ensure entered text is black
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(color: Colors.black),
                          hintText: 'Re-enter your password',
                          hintStyle: const TextStyle(
                              color: Colors.black38), // Faint placeholder
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12), // Reduced height
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color:
                                Colors.black), // Ensure entered text is black
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 0.8, // Reduce the size of the checkbox
                            child: Checkbox(
                              value: _agreeToTerms, // Bind to state variable
                              onChanged: (value) {
                                setState(() {
                                  _agreeToTerms =
                                      value ?? false; // Toggle the checkbox
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // Remove extra padding
                              activeColor: Colors
                                  .deepPurple, // Blue background (same as button color)
                              checkColor: Colors.white, // White tick
                              visualDensity: VisualDensity
                                  .compact, // Remove additional padding
                            ),
                          ),
                          const Text(
                            'I agree to the processing of ',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          const Text(
                            'Personal Data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(
                                  255, 76, 2, 99), // Different color
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width:
                            double.infinity, // Match the width of the textboxes
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.deepPurple, // Updated to match theme
                            foregroundColor: Colors.white,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text('Sign up'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Row(
                      //   children: const [
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 1,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 10),
                      //       child: Text(
                      //         'Sign up with',
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 1,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 20),
                      // Center(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       const Icon(Icons.facebook, color: Colors.blue),
                      //       const SizedBox(width: 1),
                      //       const FaIcon(FontAwesomeIcons.twitter,
                      //           color: Colors.lightBlue),
                      //       const SizedBox(width: 1),
                      //       Image.asset(
                      //         'assets/google.png',
                      //         width: 24, // Adjust the size as needed
                      //         height: 24,
                      //       ),
                      //       const SizedBox(width: 1),
                      //       const Icon(Icons.apple, color: Colors.black),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const SigninScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(
                                      1.0, 0.0); // Slide in from the right
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
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
                              text: 'Already have an account? ',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              children: [
                                TextSpan(
                                  text: 'Sign in',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16), // Updated to match theme
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
