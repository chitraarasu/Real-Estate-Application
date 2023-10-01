import 'package:flutter/material.dart';

import '../widget_utils.dart';

class SecondaryButton extends StatelessWidget {
  final bool isFromProfile;
  final String? title;
  final EdgeInsets? padding;
  final Color? color;
  final Function()? onTap;

  const SecondaryButton({
    super.key,
    this.isFromProfile = false,
    this.title,
    this.padding,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: color ?? Colors.white,
          width: isFromProfile ? 1 : 2.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: TextStyle(color: color ?? Colors.white),
      ),
      onPressed: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.all(8.0),
        child: getCustomFont(
          title ?? "Logout",
          isFromProfile ? 17 : 15,
          color ?? Colors.white,
          1,
        ),
      ),
    );
  }
}
