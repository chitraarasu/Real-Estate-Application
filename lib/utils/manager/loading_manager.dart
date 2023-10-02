import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/utils/manager/color_manager.dart';

class LoadingManager {
  static final shared = LoadingManager();
  OverlayEntry? entry;

  OverlayEntry loadingOverlayEntry() {
    return OverlayEntry(builder: (BuildContext context) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: CircularProgressIndicator(
              color: white,
            ),
          ),
        ),
      );
    });
  }

  showLoading() async {
    await Future.delayed(Duration.zero);
    final state = Overlay.of(Get.overlayContext!);
    if (entry == null) {
      entry = loadingOverlayEntry();
      state.insert(entry!);
    }
  }

  hideLoading() {
    if (entry != null) {
      entry?.remove();
      entry = null;
    }
  }
}
