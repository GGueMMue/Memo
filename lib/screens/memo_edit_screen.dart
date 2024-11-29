import 'package:flutter/material.dart';
import '../models/memo.dart';

class MemoEditScreen extends StatefulWidget {
  final Memo? memo;

  MemoEditScreen({this.memo});

  @override
  _MemoEditScreenState createState() => _MemoEditScreenState();
}

class _MemoEditScreenState extends State<MemoEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String _selectedCategory = '개인';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.memo?.title ?? '');
    _contentController = TextEditingController(text: widget.memo?.content ?? '');
    _selectedCategory = widget.memo?.category ?? '개인';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo == null ? '새 메모' : '메모 수정'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveMemo,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: '내용'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCategory,
              items: ['개인', '업무', '여행', '취미']
                  .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveMemo() {
    final newMemo = Memo(
      id: widget.memo?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      content: _contentController.text,
      category: _selectedCategory,
    );
    Navigator.pop(context, newMemo);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

