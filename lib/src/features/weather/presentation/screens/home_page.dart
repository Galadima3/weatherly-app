import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/src/features/auth/data/auth_repository.dart';
import 'package:weatherly/src/features/weather/data/networking.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final userDetails = ref.watch(userDetailsProvider);
    final weatherDetails = ref.watch(weatherDetailsProvider);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
            icon: const Icon(Icons.logout)),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        )
      ]),
      body: weatherDetails.when(
          data: (weather) {
            //var weatherData = weather.map(((e) => e));
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weather.main.temp.toString()),
                const Center(
                  child: Text('Success!'),
                ),
              ],
            );
          },
          error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive())),
    );
  }
}
