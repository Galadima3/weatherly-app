import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/src/features/auth/data/auth_repository.dart';
import 'package:weatherly/src/features/auth/presentation/screens/log_in_screen.dart';
import 'package:weatherly/src/features/auth/presentation/screens/register_screen.dart';
import 'package:weatherly/src/features/weather/presentation/screens/home_page.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null){
          return const HomePage();
        }
        return const RegisterScreen();
      },
      error: (e, trace) => const LogInScreen(),
      loading: () => const SafeArea(
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
