import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supermarket_list_app/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supermarket list app',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: GoogleFonts.kalamTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}
