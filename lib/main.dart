import 'package:criptomoedas_brasilcripto/views/principal_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrincipalPage(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0A84FF),
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFF2F2F2)),
          bodyMedium: TextStyle(color: Color(0xFF9E9E9E)),
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: Color(0xFF0A84FF),
          unselectedLabelColor: Color(0xFF9E9E9E),
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFF0A84FF), width: 3.0),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFFF2F2F2)),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
