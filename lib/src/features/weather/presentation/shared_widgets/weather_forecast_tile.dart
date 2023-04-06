import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class ForecastTile extends StatelessWidget {
  final String temp;
  final String time;
  final String imageUrl;
  const ForecastTile(
      {super.key,
      required this.temp,
      required this.time,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white54),
            color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$temp°C',
              style: const TextStyle(color: Colors.white),
            ),
            Image.network('http:$imageUrl'),
            //Text(Jiffy(time, '2021-05-25 12:00:00') as String),
            Text(
              time.substring(11),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
