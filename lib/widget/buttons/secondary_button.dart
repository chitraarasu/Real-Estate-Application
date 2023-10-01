import 'package:flutter/material.dart';
import 'package:real_estate/utils/manager/color_manager.dart';

import '../widget_utils.dart';

class SecondaryButton extends StatelessWidget {
  final bool isFromProfile;

  const SecondaryButton({super.key, this.isFromProfile = false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isFromProfile ? darkGrey : Colors.white,
          width: isFromProfile ? 1 : 2.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: TextStyle(color: isFromProfile ? darkGrey : Colors.white),
      ),
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getCustomFont(
          "Logout",
          isFromProfile ? 17 : 15,
          isFromProfile ? darkGrey : Colors.white,
          1,
        ),
      ),
    );
  }
}
