import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:todo_app/screens/auth_screen.dart';

import './screens/home_screen.dart';
import 'provider/todo_provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ToDoProvider>(create: (ctx) => ToDoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          brightness: Brightness.dark,
        ),
        home: const Home(),
      ),
    );
  }
}
