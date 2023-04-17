import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/src/constants.dart';
import 'package:weatherly/src/features/auth/data/auth_repository.dart';
import 'package:weatherly/src/features/weather/data/networking.dart';
import 'package:weatherly/src/features/search/presentation/screens/search_page.dart';
import 'package:weatherly/src/features/weather/presentation/shared_widgets/pseudo_loading_screen.dart';
import 'package:weatherly/src/features/weather/presentation/shared_widgets/weather_forecast_tile.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    //final userDetails = ref.watch(userDetailsProvider);
    final weatherDetails = ref.watch(weatherDetailsProvider);

    return weatherDetails.when(
        data: (weather) {
          return Scaffold(
            backgroundColor: const Color(0xFF010409),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                title: Row(
                  children: [
                    const Icon(Icons.location_pin),
                    Text(weather.location.name)
                  ],
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () =>
                          ref.read(authRepositoryProvider).signOut(),
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      )),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SearchPage();
                      },));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ]),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.5),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                    height: size.height * 0.72,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                            'http:${weather.current.condition.icon}',height: 100,
                            width: 100,),
                        Text(
                          '${weather.current.tempC.toStringAsFixed(0)}°',
                          style: const TextStyle(
                              fontSize: 80, color: Colors.white),
                        ),
                        Text(
                          weather.current.condition.text.name.capitalize(),
                          style: kTextStyle2,
                        ),
                        Text(DateFormat.MMMMEEEEd().format(DateTime.now()),style: kTextStyle3,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //column 1
                              Column(
                                children: [
                                  const Icon(
                                    Icons.air,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${weather.current.gustKph.toStringAsFixed(0)}km/h',
                                    style: kTextStyle1,
                                  ),
                                  const Text(
                                    'Wind',
                                    style: kTextStyle,
                                  )
                                ],
                              ),
                              //column 2
                              Column(
                                children: [
                                  const Icon(
                                    Icons.water_drop,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${weather.current.humidity}%',
                                    style: kTextStyle1,
                                  ),
                                  const Text(
                                    'Humidity',
                                    style: kTextStyle,
                                  )
                                ],
                              ),

                              //column 3
                              Column(
                                children: [
                                  const Icon(
                                    Icons.storm,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${weather.forecast.forecastday[0].day.dailyChanceOfRain}%',
                                    style: kTextStyle1,
                                  ),
                                  const Text(
                                    'Chance of Rain',
                                    style: kTextStyle,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //Text Row
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: const [
                          Text(
                            '7 Days',
                            style: TextStyle(color: Colors.white60),
                          ),
                          SizedBox(width: 3.5),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 105,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weather.forecast.forecastday[0].hour.length,
                    itemBuilder: (context, index) {
                      return ForecastTile(
                        temp: weather.forecast.forecastday[0].hour[index].tempC
                            .toString(),
                        imageUrl: weather
                            .forecast.forecastday[0].hour[index].condition.icon,
                        time: weather.forecast.forecastday[0].hour[index].time,
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) => PseudoLoadingScreen(
              status: Center(
                child: Text(error.toString()),
              ),
            ),
        loading: () => const PseudoLoadingScreen(
              status: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
