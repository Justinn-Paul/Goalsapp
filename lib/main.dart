import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const GoalsApp());
}

class GoalsApp extends StatelessWidget {
  const GoalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goals App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const App(),
    );
  }
}
