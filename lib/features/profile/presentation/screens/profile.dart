import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:tutor_pro/core/constans/constans.dart';
import 'package:tutor_pro/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tutor_pro/features/auth/presentation/screens/auth.dart';
import 'package:tutor_pro/features/home/presentation/screens/home_page.dart';
import 'package:tutor_pro/features/profile/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:tutor_pro/features/profile/presentation/screens/widgets/bottom_sheet.dart';
import 'package:tutor_pro/features/profile/presentation/screens/widgets/premium_card.dart';
import 'package:tutor_pro/features/profile/presentation/screens/widgets/profile_button.dart';
import 'package:tutor_pro/theme/cubit/theme_cubit.dart';
import 'package:tutor_pro/theme/pallete.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserCubit _userCubit;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expireController = TextEditingController();

  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
  void dispose() {
    expireController.dispose();
    cardNumberController.dispose();
    cardHolderController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
        appBar: AppBar(
          title: const Text('Профіль'),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          actions: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                return Switch.adaptive(
                  value: state == ThemeMode.light,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserSuccess) {
              final user = state.user;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        user.userName,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => authCubit.logOut(),
                        child: const ProfileButton(
                          text: 'Вийти',
                          textColor: Pallete.red,
                          svgPicture: Constans.logOutIcon,
                          color: Pallete.red,
                        ),
                      ),
                      if (!user.isPremium)
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            ExtendedCard(
                              color: Pallete.yellow,
                              title: 'Розширена',
                              price: '\$90',
                              feature: 'Надає можливість проходити тести',
                              text: 'Купити',
                              function: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const BottomSheetPayment();
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            ExtendedCard(
                              color: Pallete.lightBackground,
                              title: 'Звичайна',
                              price: '\$0',
                              text: 'Продовжити',
                              function: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomePage()),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            } else {
              return const Align(
                alignment: Alignment.center,
                child: SpinKitWanderingCubes(
                  color: Pallete.lightPurple,
                  size: 50.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
