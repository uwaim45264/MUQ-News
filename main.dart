
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_app/providers/news_provider.dart';
import 'package:new_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Optionally open a box for offline caching
  await Hive.openBox('newsCache');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
