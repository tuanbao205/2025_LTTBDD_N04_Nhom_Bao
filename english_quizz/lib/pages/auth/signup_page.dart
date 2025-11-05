import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onSwitch;
  final Function(String email, String password) onSignup;

  const SignUpPage({
    Key? key,
    required this.onSwitch,
    required this.onSignup,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Create Account",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: "Password",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => obscure = !obscure),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: confirmController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Confirm Password",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (passwordController.text != confirmController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Mật khẩu không khớp!")),
              );
              return;
            }
            widget.onSignup(emailController.text, passwordController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: widget.onSwitch,
          child: const Text("Already have an account? Log In"),
        ),
      ],
    );
  }
}
