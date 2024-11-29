import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 찾기'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: '이메일'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '이름'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('비밀번호 찾기'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: 실제 비밀번호 찾기 로직 구현
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('비밀번호 재설정 링크가 이메일로 전송되었습니다.')),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

