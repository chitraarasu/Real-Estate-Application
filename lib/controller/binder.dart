import 'package:get/get.dart';
import 'package:real_estate/controller/route_controller.dart';
import 'package:real_estate/screens/your_places/vm_new_place.dart';

import '../screens/login/vm_login.dart';

class Binder extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteController());

    Get.lazyPut(() => VMLogin(), fenix: true);
    Get.lazyPut(() => VMNewPlace(), fenix: true);
  }
}
