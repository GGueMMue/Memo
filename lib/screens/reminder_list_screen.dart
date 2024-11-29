import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../models/reminder.dart';
import '../models/memo.dart';
import '../services/dummy_data_service.dart';
import 'reminder_edit_screen.dart';
import 'memo_edit_screen.dart';

class ReminderListScreen extends StatefulWidget {
  @override
  _ReminderListScreenState createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  List<Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() {
    setState(() {
      reminders = DummyDataService.getReminders().where((reminder) => !reminder.isDeleted).toList();
    });
  }

  void _addOrUpdateReminder(Reminder? reminder) async {
    final result = await Navigator.push<Reminder>(
      context,
      MaterialPageRoute(builder: (context) => ReminderEditScreen(reminder: reminder)),
    );

    if (result != null) {
      setState(() {
        if (reminder == null) {
          reminders.add(result);
          DummyDataService.getReminders().add(result);
        } else {
          final index = reminders.indexWhere((r) => r.id == result.id);
          if (index != -1) {
            reminders[index] = result;
            final serviceIndex = DummyDataService.getReminders().indexWhere((r) => r.id == result.id);
            if (serviceIndex != -1) {
              DummyDataService.getReminders()[serviceIndex] = result;
            }
          }
        }
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
                _addMemo();
              },
            ),
            TextButton(
              child: Text('리마인더'),
              onPressed: () {
                Navigator.of(context).pop();
                _addOrUpdateReminder(null);
              },
            ),
          ],
        );
      },
    );
  }

  void _addMemo() async {
    final result = await Navigator.push<Memo>(
      context,
      MaterialPageRoute(builder: (context) => MemoEditScreen()),
    );

    if (result != null) {
      Navigator.pushReplacementNamed(context, '/memolist');
    }
  }

  void _moveToTrash(Reminder reminder) {
    setState(() {
      reminder.isDeleted = true;
      reminders.remove(reminder);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('리마인더가 휴지통으로 이동되었습니다.'),
        action: SnackBarAction(
          label: '실행 취소',
          onPressed: () {
            setState(() {
              reminder.isDeleted = false;
              reminders.add(reminder);
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
        title: Text('리마인더 목록'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                reminder.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(reminder.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        reminder.dateTime.toString().substring(0, 16),
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Chip(
                        label: Text(reminder.category),
                        backgroundColor: Theme.of(context).primaryColorLight,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _moveToTrash(reminder),
                  ),
                ],
              ),
              onTap: () => _addOrUpdateReminder(reminder),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

