import 'package:get/get.dart';
import 'package:real_estate/controller/route_controller.dart';

import '../screens/login/vm_login.dart';

class Binder extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteController());

    Get.lazyPut(() => VMLogin(), fenix: true);
  }
}
