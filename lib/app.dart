import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/auth/bloc/auth_bloc.dart';
import 'pages/auth/login_page.dart';
import 'pages/home/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthCheckRequested()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Handle auth state changes here if needed
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomePage();
            } else if (state is AuthUnauthenticated) {
              return const LoginPage();
            } else {
              // Loading state
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
