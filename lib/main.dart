import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/helpers/pref.dart';
import 'app/modules/LocationPage/controllers/location_page_controller.dart';
import 'app/modules/splash_screen.dart';

Future<void> main() async {
  await Pref.initializeHive();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FreeVPN',
      home: SplashScreen(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
