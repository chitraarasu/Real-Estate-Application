import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/c_extensions.dart';
import '../textbox/vm_textbox.dart';

class VMLogin extends GetxController {
  final formKey = GlobalKey<FormState>();
  final name = VMTextBox(
    placeholder: 'Full Name',
    keyboardType: TextInputType.text,
  );
  final emailId = VMTextBox(
    placeholder: 'Email Id',
    keyboardType: TextInputType.emailAddress,
  );
  final password = VMTextBox(
    placeholder: 'Password',
    keyboardType: TextInputType.visiblePassword,
  );

  bool validate({bool withOTP = true}) {
    hideKeyboard();

    return true;
  }
}
