import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/memo_list_screen.dart';
import 'screens/reminder_list_screen.dart';
import 'screens/trash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '메모 앱',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(secondary: Colors.tealAccent),
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/memolist': (context) => MemoListScreen(),
        '/reminderlist': (context) => ReminderListScreen(),
        '/trash': (context) => TrashScreen(),
      },
    );
  }
}

