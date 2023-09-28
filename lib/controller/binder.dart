import 'package:get/get.dart';
import 'package:real_estate/controller/route_controller.dart';

class Binder extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteController());
  }
}
