import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:real_estate/screens/dashboard/dashboard.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';

import 'controller/binder.dart';
import 'firebase_options.dart';
import 'screens/onboarding/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
