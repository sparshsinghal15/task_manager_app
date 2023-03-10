import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './router.dart';

import './providers/pending_tasks_provider.dart';
import './providers/completed_tasks_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PendingTasks()),
      ChangeNotifierProvider(create: (_) => CompletedTasks()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Task Manager App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 194, 65, 56),
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 194, 65, 56),
            padding: const EdgeInsets.all(20),
            // textStyle:
            //     const TextStyle(fontSize: 20), // This is throwing some error
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.red),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Color.fromARGB(255, 194, 65, 56),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(foregroundColor: Colors.black),
      ),
    );
  }
}
