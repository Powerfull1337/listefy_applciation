import 'package:flutter/material.dart';
import 'package:listefy_applciation/features/auth/presentation/screens/login_screen.dart';
import 'package:listefy_applciation/features/auth/presentation/screens/register_screen.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  void _toggleAuth() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin
        ? LoginScreen(onRegisterTap: _toggleAuth)
        : RegisterScreen(onLoginTap: _toggleAuth);
  }
}
