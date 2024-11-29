import 'package:flutter/material.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  '메모 앱',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                TextField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Text('로그인'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/memolist');
                  },
                ),
                SizedBox(height: 16),
                TextButton(
                  child: Text('회원가입'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
                TextButton(
                  child: Text('비밀번호 찾기'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

