import 'package:flutter/material.dart';
import '../models/memo.dart';
import '../models/reminder.dart';
import '../services/dummy_data_service.dart';
import '../widgets/drawer.dart';

class TrashScreen extends StatefulWidget {
  @override
  _TrashScreenState createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  List<dynamic> deletedItems = [];

  @override
  void initState() {
    super.initState();
    _loadDeletedItems();
  }

  void _loadDeletedItems() {
    setState(() {
      deletedItems = DummyDataService.getDeletedItems();
    });
  }

  void _restoreItem(dynamic item) {
    setState(() {
      if (item is Memo) {
        DummyDataService.restoreMemo(item.id);
      } else if (item is Reminder) {
        DummyDataService.restoreReminder(item.id);
      }
      _loadDeletedItems();
    });
  }

  void _permanentlyDeleteItem(dynamic item) {
    setState(() {
      if (item is Memo) {
        DummyDataService.permanentlyDeleteMemo(item.id);
      } else if (item is Reminder) {
        DummyDataService.permanentlyDeleteReminder(item.id);
      }
      _loadDeletedItems();
    });
  }

  void _emptyTrash() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('휴지통 비우기'),
          content: Text('정말로 휴지통의 모든 항목을 영구적으로 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                setState(() {
                  DummyDataService.emptyTrash();
                  _loadDeletedItems();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('휴지통'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: _emptyTrash,
            tooltip: '휴지통 비우기',
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: deletedItems.isEmpty
          ? Center(child: Text('휴지통이 비어있습니다.'))
          : ListView.builder(
        itemCount: deletedItems.length,
        itemBuilder: (context, index) {
          final item = deletedItems[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                item.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item is Memo ? item.content : item.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.restore, color: Colors.green),
                    onPressed: () => _restoreItem(item),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever, color: Colors.red),
                    onPressed: () => _permanentlyDeleteItem(item),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

