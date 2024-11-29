import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: '이름'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: '이메일'),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('회원가입'),
              onPressed: () {
                // TODO: 회원가입 로직 구현
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

