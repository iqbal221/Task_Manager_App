import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_apps/presentation/provider/login_provider.dart';
import 'package:task_manager_apps/presentation/screens/main_nav_bar_screen.dart';
import 'package:task_manager_apps/presentation/screens/sign_up_screen.dart';
import 'package:task_manager_apps/presentation/widgets/screen_background.dart';
import 'package:task_manager_apps/presentation/widgets/snack_bar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                  ),
                  validator: (String? value) {
                    String inputText = value ?? '';
                    if (EmailValidator.validate(inputText) == false) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  ),
                  validator: (String? value) {
                    if ((value?.length ?? 0) <= 6) {
                      return 'Password should more than 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, _) {
                    return Visibility(
                      visible: loginProvider.loginInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: FilledButton(
                        onPressed: _onTapLoginButton,
                        child: Text("Log In", style: TextStyle(fontSize: 16)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: _onTapSignUpButton,
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void _onTapLoginButton() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  Future<void> _login() async {
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text.trim(),
    };

    final provider = context.read<LoginProvider>();

    final bool isSuccess = await provider.login(requestBody);

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavBarScreen.name,
        (predict) => false,
      );
    } else {
      showSnackBarMessage(context, provider.errorMessage!);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
