import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test/controller/auth_controller.dart';
import 'package:test/custom_widget/custom_bottonav.dart';
import 'package:test/features/auth/login.dart';
import 'package:test/features/home/job_list_screen.dart';
import 'package:test/features/home/saved_job.dart';
import 'package:test/features/profile/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _index = 0;
  final _pages = const [
    JobListScreen(),
    SavedJobsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

GoRouter buildRouter(AuthController auth) => GoRouter(
  refreshListenable: auth, 
  initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/home', builder: (_, __) => const MainLayout()),
    ],
    redirect: (context, state) {
      final loggedIn = auth.isLoggedIn;
      final loggingIn = state.matchedLocation == '/login';

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/home';
      return null;
    },
  );
