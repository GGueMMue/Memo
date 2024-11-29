import '../models/memo.dart';
import '../models/reminder.dart';

class DummyDataService {
  static List<Memo> _memos = [
    Memo(id: '1', title: '쇼핑 목록', content: '우유, 빵, 계란 구매하기', category: '개인'),
    Memo(id: '2', title: '회의 준비', content: '프레젠테이션 자료 준비, 회의실 예약', category: '업무'),
    Memo(id: '3', title: '여행 계획', content: '숙소 예약, 관광지 목록 작성', category: '여행'),
  ];

  static List<Reminder> _reminders = [
    Reminder(
      id: '1',
      title: '병원 예약',
      description: '정기 검진 예약',
      dateTime: DateTime.now().add(Duration(days: 7)),
      repeatType: '없음',
      isAlarmOn: true,
      category: '개인',
    ),
    Reminder(
      id: '2',
      title: '프로젝트 마감',
      description: '최종 보고서 제출',
      dateTime: DateTime.now().add(Duration(days: 14)),
      repeatType: '없음',
      isAlarmOn: true,
      category: '업무',
    ),
    Reminder(
      id: '3',
      title: '운동',
      description: '30분 조깅',
      dateTime: DateTime.now().add(Duration(days: 1)),
      repeatType: '일간',
      isAlarmOn: true,
      category: '취미',
    ),
  ];

  static List<Memo> getMemos() {
    return _memos;
  }

  static List<Reminder> getReminders() {
    return _reminders;
  }

  static void addMemo(Memo memo) {
    _memos.add(memo);
  }

  static void updateMemo(Memo updatedMemo) {
    final index = _memos.indexWhere((memo) => memo.id == updatedMemo.id);
    if (index != -1) {
      _memos[index] = updatedMemo;
    }
  }

  static void deleteMemo(String id) {
    final memo = _memos.firstWhere((memo) => memo.id == id);
    memo.isDeleted = true;
  }

  static void restoreMemo(String id) {
    final memo = _memos.firstWhere((memo) => memo.id == id);
    memo.isDeleted = false;
  }

  static void permanentlyDeleteMemo(String id) {
    _memos.removeWhere((memo) => memo.id == id);
  }

  static void addReminder(Reminder reminder) {
    _reminders.add(reminder);
  }

  static void updateReminder(Reminder updatedReminder) {
    final index = _reminders.indexWhere((reminder) => reminder.id == updatedReminder.id);
    if (index != -1) {
      _reminders[index] = updatedReminder;
    }
  }

  static void deleteReminder(String id) {
    final reminder = _reminders.firstWhere((reminder) => reminder.id == id);
    reminder.isDeleted = true;
  }

  static void restoreReminder(String id) {
    final reminder = _reminders.firstWhere((reminder) => reminder.id == id);
    reminder.isDeleted = false;
  }

  static void permanentlyDeleteReminder(String id) {
    _reminders.removeWhere((reminder) => reminder.id == id);
  }

  static List<dynamic> getDeletedItems() {
    return [
      ..._memos.where((memo) => memo.isDeleted),
      ..._reminders.where((reminder) => reminder.isDeleted),
    ];
  }

  static void emptyTrash() {
    _memos.removeWhere((memo) => memo.isDeleted);
    _reminders.removeWhere((reminder) => reminder.isDeleted);
  }
}

