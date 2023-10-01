import 'package:flutter/material.dart';
import 'package:real_estate/utils/manager/color_manager.dart';

import '../utils/resizer/fetch_pixels.dart';

class Search extends StatelessWidget {
  Function(String)? onChange;
  final TextEditingController? controller;
  final bool? enable;

  Search({super.key, this.onChange, this.controller, this.enable});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FetchPixels.getPixelHeight(40),
      decoration: const BoxDecoration(
        color: Color(0xFFebebec),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Center(
        child: TextField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          maxLines: 1,
          onChanged: onChange,
          enabled: enable,
          autofocus: enable ?? false,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(
              color: darkGrey,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 2.5),
            prefixIcon: Icon(
              Icons.search,
              color: darkGrey,
              size: FetchPixels.getHeightPercentSize(3),
            ),
            suffixIcon: Icon(
              Icons.mic,
              color: darkGrey,
              size: FetchPixels.getHeightPercentSize(3),
            ),
          ),
        ),
      ),
    );
  }
}
