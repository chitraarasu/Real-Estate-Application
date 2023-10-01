import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate/screens/textbox/first_textbox.dart';
import 'package:real_estate/screens/your_places/vm_new_place.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/color_manager.dart';
import 'package:real_estate/widget/appbar/first_appbar.dart';
import 'package:real_estate/widget/buttons/primary_button.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../model/m_category.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../home/vm_home.dart';

class AddNewPlace extends StatelessWidget {
  AddNewPlace({super.key});

  VMHome vmHome = VMHome.to;
  RxBool selectedWay = RxBool(true);
  RxBool selectedMap = RxBool(true);

  Rx<List<Marker>> customMarkers = Rx([]);

  Marker buildPin(LatLng point) => Marker(
        point: point,
        builder: (ctx) => Image(
          image: AssetImage("home_marker".png),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final data = Get.find<VMNewPlace>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelHeight(8),
            horizontal: FetchPixels.getPixelHeight(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FirstAppBar(
                title: "Add new place",
                onBack: () {
                  Get.back();
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      vSpace(10),
                      FirstTextBox(data: data.name),
                      vSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: FirstTextBox(
                              data: data.mobile,
                              maxLines: 1,
                            ),
                          ),
                          hSpace(5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getCustomFont(
                                  "Category",
                                  14,
                                  darkGrey,
                                  1,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: grey.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Obx(
                                      () => DropdownButton<CategoryModel>(
                                        value: data.selectedItem.value,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: vmHome.category
                                            .map((CategoryModel items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.title),
                                          );
                                        }).toList(),
                                        onChanged: (CategoryModel? newValue) {
                                          data.selectedItem.value = newValue;
                                        },
                                        isExpanded: true,
                                        underline: Container(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      vSpace(15),
                      FirstTextBox(
                        data: data.address,
                        maxLines: 1,
                      ),
                      vSpace(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: FirstTextBox(
                              data: data.price,
                              maxLines: 1,
                            ),
                          ),
                          hSpace(5),
                          Expanded(
                            child: Obx(
                              () => AnimatedToggleSwitch<bool>.size(
                                current: selectedWay.value,
                                values: const [true, false],
                                indicatorSize:
                                    const Size.fromWidth(double.infinity),
                                customIconBuilder: (context, local, global) =>
                                    Text(
                                  (local.value ? 'Sale' : 'Rent'),
                                  style: TextStyle(
                                    color: Color.lerp(
                                      Colors.black,
                                      Colors.black,
                                      local.animationValue,
                                    ),
                                    fontSize: 15,
                                  ),
                                ),
                                borderWidth: 2.0,
                                iconAnimationType: AnimationType.onSelected,
                                style: ToggleStyle(
                                  indicatorColor: white,
                                  backgroundColor: Color(0xFFebebec),
                                  borderColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                selectedIconScale: 1.0,
                                height: 50,
                                onChanged: (b) {
                                  selectedWay.value = b;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      vSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: FirstTextBox(
                              data: data.beds,
                              maxLines: 1,
                            ),
                          ),
                          hSpace(5),
                          Expanded(
                            child: FirstTextBox(
                              data: data.bath,
                              maxLines: 1,
                            ),
                          ),
                          hSpace(5),
                          Expanded(
                            child: FirstTextBox(
                              data: data.sqft,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      vSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: getCustomFont(
                              "Select Images",
                              14,
                              darkGrey,
                              1,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: darkGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: getPaddingWidget(
                              EdgeInsets.all(4),
                              child: Icon(
                                Icons.add,
                                color: white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      vSpace(10),
                      SizedBox(
                        height: FetchPixels.getPixelHeight(85),
                        child: ReorderableListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              key: ValueKey(index),
                              child: getPaddingWidget(
                                EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image(
                                        width: FetchPixels.getPixelWidth(150),
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://via.placeholder.com/400x500",
                                        ),
                                      ),
                                      getPaddingWidget(EdgeInsets.all(2),
                                          child: Icon(Icons.close)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {},
                        ),
                      ),
                      vSpace(15),
                      FirstTextBox(
                        data: data.description,
                        maxLines: 6,
                      ),
                      vSpace(15),
                      Row(
                        children: [
                          getCustomFont(
                            "Select Location",
                            14,
                            darkGrey,
                            1,
                          ),
                        ],
                      ),
                      vSpace(10),
                      Obx(
                        () => AnimatedToggleSwitch<bool>.size(
                          current: selectedMap.value,
                          values: const [true, false],
                          indicatorSize: const Size.fromWidth(double.infinity),
                          customIconBuilder: (context, local, global) => Text(
                            (local.value
                                ? 'Use Current Location'
                                : 'Pick From Map'),
                            style: TextStyle(
                              color: Color.lerp(
                                Colors.black,
                                Colors.black,
                                local.animationValue,
                              ),
                              fontSize: 15,
                            ),
                          ),
                          borderWidth: 2.0,
                          iconAnimationType: AnimationType.onSelected,
                          style: ToggleStyle(
                            indicatorColor: white,
                            backgroundColor: Color(0xFFebebec),
                            borderColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          selectedIconScale: 1.0,
                          height: 40,
                          onChanged: (b) {
                            selectedMap.value = b;
                          },
                        ),
                      ),
                      vSpace(15),
                      SizedBox(
                        height: FetchPixels.getPixelHeight(180),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Obx(
                            () => FlutterMap(
                              options: MapOptions(
                                  center: LatLng(20.5937, 78.9629),
                                  zoom: 5,
                                  onTap: (_, p) {
                                    customMarkers.value = [buildPin(p)];
                                  }),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                MarkerLayer(
                                  markers: [
                                    // Marker(
                                    //   point: LatLng(14.059274, 76.385020),
                                    //   builder: (context) => GestureDetector(
                                    //     onTap: () {},
                                    //     child: Image(
                                    //       image: AssetImage("home_marker".png),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                MarkerLayer(
                                  markers: customMarkers.value,
                                  rotate: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      vSpace(30),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              "Send For Approval",
                              radius: 10,
                            ),
                          ),
                        ],
                      ),
                      vSpace(40),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
