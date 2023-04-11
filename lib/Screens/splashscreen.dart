import 'dart:async';
import 'package:apiwallpaperappwithbloc/Screens/wallpaperscreen.dart';
import 'package:apiwallpaperappwithbloc/Utils/constants.dart';
import 'package:apiwallpaperappwithbloc/Widgets/loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WallpaperScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Creative XPress',
              style: TextStyle(fontSize: 40, fontFamily: handlee),
            ),
            SizedBox(
              height: 20,
            ),
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
