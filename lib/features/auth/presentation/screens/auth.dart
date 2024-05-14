import 'package:flutter/material.dart';
import 'package:tutor_pro/features/auth/presentation/screens/sign_in.dart';
import 'package:tutor_pro/features/auth/presentation/screens/sign_up.dart';
import 'package:tutor_pro/theme/pallete.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 95,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'TutorPro.',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Pallete.lightPurple),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                isScrollable: false,
                labelPadding: const EdgeInsets.only(right: 30),
                labelStyle: const TextStyle(
                  fontFamily: 'Fixel',
                  color: Color(0xFF101213),
                  fontSize: 32,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Fixel',
                  color: Color(0xFF101213),
                  fontSize: 32,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
                indicatorWeight: 4,
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Sign Up'),
                  Tab(text: 'Sign In'),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 470,
              child: TabBarView(
                controller: _tabController,
                children: const [SignUpPage(), SignInPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
