import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/src/features/auth/data/auth_repository.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => ref.read(authRepositoryProvider).signOut(), icon: const Icon(Icons.logout))
        ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(userDetails!.email ?? 'No name found'),
          const Center(
            child: Text('Success!'),
          ),
        ],
      ),
    );
  }
}
