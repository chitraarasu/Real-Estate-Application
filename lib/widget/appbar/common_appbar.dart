import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/utils/c_extensions.dart';

import '../../controller/route_controller.dart';
import '../../screens/your_places/add_new_place.dart';
import '../../utils/manager/color_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final bool isMyPlace;
  final bool isProfile;
  final bool isEditModeOn;
  final Function()? onEditClick;
  final Function()? onDoneClick;

  const CommonAppBar({
    super.key,
    this.isHome = false,
    this.isMyPlace = false,
    this.isProfile = false,
    this.isEditModeOn = false,
    this.onEditClick,
    this.onDoneClick,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          RouteController.to.toggleDrawer();
        },
        icon: ImageIcon(
          AssetImage("menu".png),
          size: 37.5,
          color: Colors.black,
        ),
      ),
      actions: [
        if (isHome)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                RouteController.to.currentPos.value = 3;
              },
              icon: ImageIcon(
                AssetImage("heart".png),
                size: 24,
                // width: FetchPixels.getPixelWidth(20),
                // height: FetchPixels.getPixelHeight(20),
                color: darkBlue,
                // scale: FetchPixels.getScale(),
              ),
            ),
          ),
        if (isMyPlace)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: darkBlue,
              child: IconButton(
                onPressed: () {
                  Get.to(() => AddNewPlace());
                },
                icon: Icon(
                  Icons.add_box_rounded,
                  size: FetchPixels.getPixelWidth(20),
                  color: white,
                ),
              ),
            ),
          ),
        if (isProfile)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: darkBlue,
              child: IconButton(
                onPressed: onEditClick,
                icon: Icon(
                  Icons.edit,
                  size: FetchPixels.getPixelWidth(20),
                  color: white,
                ),
              ),
            ),
          ),
        if (isEditModeOn)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: darkBlue,
              child: IconButton(
                onPressed: onDoneClick,
                icon: Icon(
                  Icons.done,
                  size: FetchPixels.getPixelWidth(20),
                  color: white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
