import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:baguette/core/theme.dart';
import 'package:baguette/features/auth/login_screen.dart';
import 'package:baguette/features/auth/register_screen.dart';
import 'package:baguette/features/home/home_screen.dart';
import 'package:baguette/features/home/home_dashboard.dart';
import 'package:baguette/features/laws/laws_screen.dart';
import 'package:baguette/features/laws/law_details_screen.dart';
import 'package:baguette/features/deputies/deputies_screen.dart';
import 'package:baguette/features/deputies/deputy_details_screen.dart';
import 'package:baguette/features/profile/profile_screen.dart';

// import 'package:supabase_flutter/supabase_flutter.dart'; // Uncomment when real setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );

  runApp(const ProviderScope(child: LaBaguetteApp()));
}

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeDashboard(),
        ),
        GoRoute(path: '/laws', builder: (context, state) => const LawsScreen()),
        GoRoute(
          path: '/law/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return LawDetailsScreen(lawId: id);
          },
        ),
        GoRoute(
          path: '/deputies',
          builder: (context, state) => const DeputiesScreen(),
        ),
        GoRoute(
          path: '/deputy/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DeputyDetailsScreen(deputyId: id);
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

class LaBaguetteApp extends ConsumerWidget {
  const LaBaguetteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'La Baguette',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
