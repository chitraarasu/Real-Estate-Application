import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:real_estate/screens/dashboard/dashboard.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';

import 'controller/binder.dart';
import 'firebase_options.dart';
import 'screens/onboarding/onboarding_page.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  Future.delayed(const Duration(seconds: 1), () {
    FlutterNativeSplash.remove();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Real Estate",
      initialBinding: Binder(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: fontNunito,
      ),
      home: (box.read("isSkipped") ?? false) ? Dashboard() : OnBoardingPage(),
    );
  }
}
