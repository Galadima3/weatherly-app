import 'package:flutter/material.dart';

class PseudoLoadingScreen extends StatelessWidget {
  final Widget status;
  const PseudoLoadingScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: status,
    ));
  }
}
