import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/features/auth/presentation/bloc/auth_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
