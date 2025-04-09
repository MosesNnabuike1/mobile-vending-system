import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:mobile_vending_app/api_services.dart';
import 'package:mobile_vending_app/signin_screen.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email; // Email passed from the registration page

  const EmailVerificationPage({super.key, required this.email});

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final ApiService _apiService = ApiService('https://bigice.portiola.com/api/v1');
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  String _errorMessage = ""; // Error message to display
  bool _isVerifying = false; // State for verifying process
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 600; // 60 seconds

  void _verifyCode() async {
    String enteredCode = _controllers.map((c) => c.text).join();

    if (enteredCode.isEmpty || enteredCode.length < 4) {
      setState(() {
        _errorMessage = "Please enter the complete code.";
      });
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorMessage = "";
    });

    try {
      final response = await _apiService.verifyEmail(token: enteredCode);

      if (response['status'] == 'success') {
        // Navigate to the Signin page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SigninScreen()),
        );
      } else {
        // Display error message if the code is invalid
        setState(() {
          _errorMessage = response['message'] ?? "Invalid code. Please try again.";
        });
      }
    } catch (e) {
      // Handle unexpected errors
      setState(() {
        _errorMessage = "Error: $e";
      });
    } finally {
      setState(() {
        _isVerifying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(40.0, 70.0, 40.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Check your email",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We've sent the code to your email.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/email.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => _buildCodeBox(index),
              ),
            ),
            const SizedBox(height: 10),
            CountdownTimer(
              endTime: endTime,
              widgetBuilder: (_, time) {
                if (time == null) {
                  return const Text(
                    "Code expired",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  );
                }
                return Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Code expires in: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextSpan(
                        text: "${time.min ?? "00"}:${time.sec ?? "00"}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isVerifying ? null : _verifyCode,
              child: _isVerifying
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeBox(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 53,
        height: 55,
        child: TextField(
          controller: _controllers[index],
          textAlign: TextAlign.center,
          maxLength: 1,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            border: Theme.of(context).inputDecorationTheme.border,
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
