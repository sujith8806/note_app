import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/utils/app_sessions.dart';
import 'package:note_app/view/home_screen/home_screen.dart';

void main() async {

   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box=await Hive.openBox(AppSessions.noteBox);
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }}