import 'package:flutter/material.dart';
import 'package:real_estate/utils/c_extensions.dart';

import '../../controller/route_controller.dart';
import '../../utils/manager/color_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final bool isMyPlace;
  final bool isProfile;

  const CommonAppBar({
    super.key,
    this.isHome = false,
    this.isMyPlace = false,
    this.isProfile = false,
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
              icon: Image.asset(
                "heart_active".png,
                width: FetchPixels.getPixelWidth(20),
                height: FetchPixels.getPixelHeight(20),
                color: darkBlue,
                scale: FetchPixels.getScale(),
              ),
            ),
          ),
        if (isMyPlace)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: darkBlue,
              child: IconButton(
                onPressed: () {},
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
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
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
