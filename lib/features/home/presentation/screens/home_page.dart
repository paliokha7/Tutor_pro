import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tutor_pro/core/constans/constans.dart';
import 'package:tutor_pro/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tutor_pro/features/history/history.dart';
import 'package:tutor_pro/features/home/presentation/screens/list_of_subjects.dart';
import 'package:tutor_pro/features/profile/presentation/screens/profile.dart';
import 'package:tutor_pro/theme/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            children: const [
              Subjects(),
              History(),
              Profile(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 13,
                  offset: const Offset(0, -3),
                ),
              ],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: SalomonBottomBar(
              backgroundColor: Pallete.white,
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }),
              items: [
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    Constans.homeIcon,
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 0 ? Pallete.lightPurple : Pallete.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: const Text('Home'),
                  selectedColor: Pallete.lightPurple,
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    Constans.histiryIcon,
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 1 ? Pallete.lightPurple : Pallete.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: const Text('History'),
                  selectedColor: Pallete.lightPurple,
                ),
                SalomonBottomBarItem(
                  icon: SvgPicture.asset(
                    Constans.profileIcon,
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 2 ? Pallete.lightPurple : Pallete.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: const Text('Profile'),
                  selectedColor: Pallete.lightPurple,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
