import 'package:flutter/material.dart';

import '../../utils/manager/font_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/appbar/common_appbar.dart';
import '../../widget/widget_utils.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(isProfile: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelHeight(8),
            horizontal: FetchPixels.getPixelHeight(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont(
                "Profile",
                20,
                Colors.black,
                1,
                fontWeight: bold,
              ),
              vSpace(15),
            ],
          ),
        ),
      ),
    );
  }
}
