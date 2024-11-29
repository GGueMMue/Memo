import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../models/memo.dart';
import '../models/reminder.dart';
import '../services/dummy_data_service.dart';
import 'memo_edit_screen.dart';
import 'reminder_edit_screen.dart';

class MemoListScreen extends StatefulWidget {
  @override
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  List<Memo> memos = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMemos();
  }

  void _loadMemos() {
    setState(() {
      memos = DummyDataService.getMemos().where((memo) => !memo.isDeleted).toList();
    });
  }

  void _addOrUpdateMemo(Memo? memo) async {
    final result = await Navigator.push<Memo>(
      context,
      MaterialPageRoute(builder: (context) => MemoEditScreen(memo: memo)),
    );

    if (result != null) {
      setState(() {
        if (memo == null) {
          DummyDataService.addMemo(result);
        } else {
          DummyDataService.updateMemo(result);
        }
        _loadMemos();
      });
    }
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('새 항목 생성'),
          content: Text('어떤 항목을 생성하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('메모'),
              onPressed: () {
                Navigator.of(context).pop();
                _addOrUpdateMemo(null);
              },
            ),
            TextButton(
              child: Text('리마인더'),
              onPressed: () {
                Navigator.of(context).pop();
                _addReminder();
              },
            ),
          ],
        );
      },
    );
  }

  void _addReminder() async {
    final result = await Navigator.push<Reminder>(
      context,
      MaterialPageRoute(builder: (context) => ReminderEditScreen()),
    );

    if (result != null) {
      Navigator.pushReplacementNamed(context, '/reminderlist');
    }
  }

  void _moveToTrash(Memo memo) {
    setState(() {
      DummyDataService.deleteMemo(memo.id);
      _loadMemos();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('메모가 휴지통으로 이동되었습니다.'),
        action: SnackBarAction(
          label: '실행 취소',
          onPressed: () {
            setState(() {
              DummyDataService.restoreMemo(memo.id);
              _loadMemos();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 목록'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: '검색',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memo = memos[index];
                if (searchQuery.isEmpty ||
                    memo.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                    memo.content.toLowerCase().contains(searchQuery.toLowerCase())) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        memo.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        memo.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            label: Text(memo.category),
                            backgroundColor: Theme.of(context).primaryColorLight,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _moveToTrash(memo),
                          ),
                        ],
                      ),
                      onTap: () => _addOrUpdateMemo(memo),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

