import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/login/vm_login.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/widget/buttons/primary_button.dart';

import '../../widget/widget_utils.dart';
import '../textbox/first_textbox.dart';

class LoginScreen extends StatelessWidget {
  final Function? onDone;

  LoginScreen({this.onDone});

  @override
  Widget build(BuildContext context) {
    final data = Get.find<VMLogin>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(top: 35, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: data.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        "Welcome",
                        22,
                        Colors.black,
                        1,
                        fontWeight: bold,
                      ),
                      const SizedBox(height: 16),
                      FirstTextBox(
                        data: data.emailId,
                      ),
                      Column(
                        children: [
                          vSpace(16),
                          FirstTextBox(
                            data: data.name,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FirstTextBox(
                        data: data.password,
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton("Login", radius: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

openSignInAlert({Function? onDone}) async {
  await Get.bottomSheet(
    LoginScreen(onDone: onDone),
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.30),
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.only(
    //     topLeft: Radius.circular(24),
    //     topRight: Radius.circular(24),
    //   ),
    // ),
    isDismissible: true,
    isScrollControlled: true,
  );
}
