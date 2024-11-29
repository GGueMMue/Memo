import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderEditScreen extends StatefulWidget {
  final Reminder? reminder;

  ReminderEditScreen({this.reminder});

  @override
  _ReminderEditScreenState createState() => _ReminderEditScreenState();
}

class _ReminderEditScreenState extends State<ReminderEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  String _selectedRepeatType = '없음';
  bool _isAlarmOn = true;
  String _selectedCategory = '개인';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder?.title ?? '');
    _descriptionController = TextEditingController(text: widget.reminder?.description ?? '');
    _selectedDate = widget.reminder?.dateTime ?? DateTime.now();
    _selectedTime = TimeOfDay.fromDateTime(widget.reminder?.dateTime ?? DateTime.now());
    _selectedRepeatType = widget.reminder?.repeatType ?? '없음';
    _isAlarmOn = widget.reminder?.isAlarmOn ?? true;
    _selectedCategory = widget.reminder?.category ?? '개인';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder == null ? '새 리마인더' : '리마인더 수정'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final newReminder = Reminder(
                id: widget.reminder?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                title: _titleController.text,
                description: _descriptionController.text,
                dateTime: DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                  _selectedTime.hour,
                  _selectedTime.minute,
                ),
                repeatType: _selectedRepeatType,
                isAlarmOn: _isAlarmOn,
                category: _selectedCategory,
              );
              Navigator.pop(context, newReminder);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: '세부 내용'),
              maxLines: null,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('날짜 선택: ${_selectedDate.toString().substring(0, 10)}'),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text('시간 선택: ${_selectedTime.format(context)}'),
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (picked != null && picked != _selectedTime) {
                        setState(() {
                          _selectedTime = picked;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedRepeatType,
              items: ['없음', '일간', '주간', '월간']
                  .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedRepeatType = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('알림'),
                Switch(
                  value: _isAlarmOn,
                  onChanged: (bool value) {
                    setState(() {
                      _isAlarmOn = value;
                    });
                  },
                ),
              ],
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
}

