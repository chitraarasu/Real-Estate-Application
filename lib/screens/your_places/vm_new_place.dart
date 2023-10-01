import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/m_category.dart';
import '../../utils/c_extensions.dart';
import '../textbox/vm_textbox.dart';

class VMNewPlace extends GetxController {
  final formKey = GlobalKey<FormState>();
  final name = VMTextBox(
    placeholder: 'Place Name',
    keyboardType: TextInputType.text,
  );
  final mobile = VMTextBox(
    placeholder: 'Mobile Number',
    keyboardType: TextInputType.visiblePassword,
  );
  final address = VMTextBox(
    placeholder: 'Address',
    keyboardType: TextInputType.emailAddress,
  );
  final beds = VMTextBox(
    placeholder: 'Beds',
    keyboardType: TextInputType.visiblePassword,
  );
  final bath = VMTextBox(
    placeholder: 'Bathrooms',
    keyboardType: TextInputType.visiblePassword,
  );
  final sqft = VMTextBox(
    placeholder: 'Sqft',
    keyboardType: TextInputType.visiblePassword,
  );
  final price = VMTextBox(
    placeholder: 'Price',
    keyboardType: TextInputType.visiblePassword,
  );
  final description = VMTextBox(
    placeholder: 'Description',
    keyboardType: TextInputType.visiblePassword,
  );
  Rxn<CategoryModel> selectedItem = Rxn();

  bool validate({bool withOTP = true}) {
    hideKeyboard();

    return true;
  }
}
