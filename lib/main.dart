import 'package:apiwallpaperappwithbloc/Utils/constants.dart';
import 'package:apiwallpaperappwithbloc/cubit/wallpaper_cubit.dart';
import 'package:apiwallpaperappwithbloc/Screens/splashscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperCubit()..getWallpapers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        title: 'Wall Print',
        home: const SplashScreen(),
      ),
    );
  }
}
