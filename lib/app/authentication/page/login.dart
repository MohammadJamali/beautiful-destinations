import 'package:beautiful_destinations/app/authentication/bloc/login/login_bloc.dart';
import 'package:beautiful_destinations/app/authentication/view/login.dart';
import 'package:beautiful_destinations/repositories/authentication/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const LoginView(),
        ),
      ),
    );
  }
}
