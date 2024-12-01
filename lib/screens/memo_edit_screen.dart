import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/memo.dart';

class MemoSave{
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime data_Time;

  MemoSave(
    {
      required this.id,
      required this.title,
      required this.content,
      required this.category,
      required this.data_Time,
    }
  );
  Map<String, dynamic> toJson() => {
    'memoId' : id,
    'title' : title,
    'content' : content,
    'category' : category,
    'timestamp' : data_Time.toIso8601String(),
  };

  factory MemoSave.fromJson(Map<String, dynamic> json) => MemoSave(
      id: json['memoId'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      data_Time: DateTime.parse(json['data_Time']),
  );
}


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
  List<MemoSave> _memoSave = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.memo?.title ?? '');
    _contentController = TextEditingController(text: widget.memo?.content ?? '');
    _selectedCategory = widget.memo?.category ?? '개인';
    _loadHistory();
  }

  Future<void> _loadHistory() async
  {
    final prefs = await SharedPreferences.getInstance();
    final memoId = widget.memo?.id;
    if(memoId != null)
      {
        final jsonHistory = prefs.getStringList('memo_history_$memoId') ?? [];
        print('로드 히스토리: $jsonHistory');
        setState(() {
          _memoSave = jsonHistory
              .map((json) => MemoSave.fromJson(jsonDecode(json))).toList();
        });
      }
  }

  Future<void> _saveHistroy() async
  {
    if(widget.memo != null)
      {
        final history = MemoSave(
            id: widget.memo!.id,
            title: _titleController.text,
            content: _contentController.text,
            category: _selectedCategory,
            data_Time: DateTime.now(),
        );

        _memoSave.add(history);

        if(_memoSave.length > 10)
          _memoSave.removeAt(0);

        final prefs = await SharedPreferences.getInstance();
        final jsonHistory = _memoSave
          .map((history) => jsonEncode(history.toJson())).toList();

        print('저장된 히스토리: $jsonHistory'); // data check
        await prefs.setStringList('memo_history_${widget.memo!.id}', jsonHistory);
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo == null ? '새 메모' : '메모 수정'),
        actions: [
          if(widget.memo != null)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveMemo,
            ),
          IconButton(onPressed: _saveMemo, icon: Icon(Icons.save))
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

  void _showHistroy()
  {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('메모 히스토리'),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _memoSave.length,
              itemBuilder: (context, index){
                final history = _memoSave[_memoSave.length - 1 - index]; // show memo as earlier data
                return ListTile(
                  title: Text(history.title),
                  subtitle: Text(
                    '${history.category} - ${DateFormat('yyyy-MM-dd HH:mm').format(history.data_Time)}',
                  ),
                  onTap: () {
                    setState(() {
                      _titleController.text = history.title;
                      _contentController.text = history.content;
                      _selectedCategory = history.category;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
                child: Text('닫기'),
            ),
          ],
        ),
    );
  }

  void _saveMemo() async {
    final newMemo = Memo(
      id: widget.memo?.id ?? DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      title: _titleController.text,
      content: _contentController.text,
      category: _selectedCategory,
    );

    await _saveHistroy();
    Navigator.pop(context, newMemo);
  }
/*
    void _memoSave()
    {
      final newMemo =
          Memo(id: widget.memo?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
            title:  _titleController.text,
            content: _contentController.text,
            category: _selectedCategory,
          ); // saving memo

      _memoSave.add(MemoSave(id: newMemo.id,
          title: newMemo.title,
          content: newMemo.content,
          category: newMemo.category,
          data_Time: newMemo.data_Time))
    }



    Navigator.pop(context, newMemo);
  }*/

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

