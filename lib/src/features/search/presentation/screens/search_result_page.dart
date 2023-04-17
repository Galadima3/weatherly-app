import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/src/features/search/data/search_networking.dart';
import 'package:weatherly/src/features/search/domain/search_model.dart';


class SearchResultPage extends ConsumerStatefulWidget {
  final String searchTerm;
  const SearchResultPage({required this.searchTerm, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchResultPageState();
}

class _SearchResultPageState extends ConsumerState<SearchResultPage> {
  late AsyncValue searchData;
  late Future<SearchWeatherModel> _value;

  @override
  void initState() {
    super.initState();
    //searchData = ref.read(cityWeatherDetailsProvider(widget.searchTerm));
    _value = _getCityData();
  }

  Future<SearchWeatherModel> _getCityData() {
    return CityWeatherNetworking().getCityWeather(widget.searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('An error has occurred'));
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    //pseudo appbar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_pin),
                        Text(widget.searchTerm)
                      ],
                    ),
                    
                  ],
                );
                // return Center(
                //   child: Text(snapshot.data?.main.temp.toString() ?? 'Weather not available'),
                // );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}
