import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weatherly/src/features/search/presentation/screens/search_result_page.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});
  final searchController = TextEditingController();
  void goToNextPage(String searchTerm, context) async {
    if (searchTerm.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultPage(searchTerm: searchTerm),
          ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //spacing
            const SizedBox(height: 50),
            //textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onSubmitted: (value) =>
                      goToNextPage(searchController.text, context),
                  controller: searchController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: 'Search for City',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

