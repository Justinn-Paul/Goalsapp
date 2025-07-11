import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'pages/auth/widgets/welcome_screen.dart';
import 'pages/home/bloc/home_bloc.dart';
import 'pages/home/home_page.dart';
import 'package:user_repository/user_repository.dart';
import 'package:goals_repository/goals_repository.dart';
import 'pages/home/bloc/home_event.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goals App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          onBackground: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return const HomePage();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
