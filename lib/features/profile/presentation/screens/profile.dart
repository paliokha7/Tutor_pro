import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/core/constans/constans.dart';
import 'package:tutor_pro/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tutor_pro/features/auth/presentation/screens/auth.dart';
import 'package:tutor_pro/features/profile/presentation/cubit/user_cubit.dart';
import 'package:tutor_pro/features/profile/presentation/screens/widgets/profile_button.dart';
import 'package:tutor_pro/theme/pallete.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    _getUserData();
  }

  void _getUserData() {
    _userCubit.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AuthScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('History'),
              centerTitle: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserSuccess) {
                      final user = state.user;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.userName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ProfileButton(
                              text: 'Change Password',
                              textColor: Pallete.black,
                              svgPicture: Constans.eyeIcon,
                              color: Pallete.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const ProfileButton(
                              text: 'Language',
                              textColor: Pallete.black,
                              svgPicture: Constans.worldIcon,
                              color: Pallete.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const ProfileButton(
                              text: 'Support',
                              textColor: Pallete.black,
                              svgPicture: Constans.supportIcon,
                              color: Pallete.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () => authCubit.logOut(),
                              child: const ProfileButton(
                                text: 'Logout',
                                textColor: Pallete.red,
                                svgPicture: Constans.eyeIcon,
                                color: Pallete.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is UserError) {
                      return Center(
                        child: Text('Error: ${state.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
