import 'package:flutter/material.dart';
import '../../main.dart'; 

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  Map<String, Map<String, String>> users = {}; 

  bool _isValidEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void _handleSignup(String name, String email, String password) {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage('Vui lòng điền đầy đủ thông tin!');
      return;
    }
    if (!_isValidEmail(email)) {
      _showMessage('Email không hợp lệ!');
      return;
    }
    if (password.length < 6) {
      _showMessage('Mật khẩu phải có ít nhất 6 ký tự!');
      return;
    }
    if (users.containsKey(email)) {
      _showMessage('Email đã được đăng ký!');
      return;
    }

    users[email] = {'name': name, 'password': password};
    _showMessage('Đăng ký thành công! Vui lòng đăng nhập.');
    setState(() => isLogin = true);
  }

  void _handleLogin(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      _showMessage('Vui lòng điền đầy đủ thông tin!');
      return;
    }
    if (!_isValidEmail(email)) {
      _showMessage('Email không hợp lệ!');
      return;
    }
    if (!users.containsKey(email)) {
      _showMessage('Email chưa được đăng ký!');
      return;
    }
    if (users[email]!['password'] != password) {
      _showMessage('Mật khẩu không đúng!');
      return;
    }

    _showMessage('Đăng nhập thành công!');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.teal,
                          Colors.teal,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: isLogin
                    ? LoginForm(
                        onSwitchToSignup: () => setState(() => isLogin = false),
                        onLogin: _handleLogin,
                      )
                    : SignupForm(
                        onSwitchToLogin: () => setState(() => isLogin = true),
                        onSignup: _handleSignup,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);

    var firstStart = Offset(size.width / 4, 30);
    var firstEnd = Offset(size.width / 2, 0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width * 3 / 4, -30);
    var secondEnd = Offset(size.width, 0);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LoginForm extends StatefulWidget {
  final VoidCallback onSwitchToSignup;
  final Function(String email, String password) onLogin;

  const LoginForm({
    Key? key,
    required this.onSwitchToSignup,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hi there!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        Text(
          'Welcome back.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 40),

        // Email
        const Text('Email', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'example@gmail.com',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 20),

        // Password
        const Text('Password', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: '••••••••',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => widget.onLogin(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('New member?', style: TextStyle(color: Colors.grey[600])),
            TextButton(
              onPressed: widget.onSwitchToSignup,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SignupForm extends StatefulWidget {
  final VoidCallback onSwitchToLogin;
  final Function(String name, String email, String password) onSignup;

  const SignupForm({
    Key? key,
    required this.onSwitchToLogin,
    required this.onSignup,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _obscurePassword = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 40),

        _buildTextField('Name', _nameController, hint: 'example'),
        const SizedBox(height: 20),
        _buildTextField('Email', _emailController,
            hint: 'example@gmail.com', email: true),
        const SizedBox(height: 20),
        _buildTextField('Password', _passwordController,
            hint: '••••••••', obscure: _obscurePassword, suffix: true),
        const SizedBox(height: 40),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => widget.onSignup(
              _nameController.text.trim(),
              _emailController.text.trim(),
              _passwordController.text,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account?',
                style: TextStyle(color: Colors.grey[600])),
            TextButton(
              onPressed: widget.onSwitchToLogin,
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    bool email = false,
    bool obscure = false,
    bool suffix = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType:
              email ? TextInputType.emailAddress : TextInputType.text,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: suffix
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
