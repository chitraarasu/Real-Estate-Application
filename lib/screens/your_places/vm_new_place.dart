import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:real_estate/utils/manager/toast_manager.dart';

import '../../model/m_category.dart';
import '../../utils/c_extensions.dart';
import '../textbox/vm_textbox.dart';

class VMNewPlace extends GetxController {
  Rx<List<Marker>> customMarkers = Rx([]);
  Rxn<File> selectedPdf = Rxn<File>();
  Rx<List<File>> selectedImages = Rx<List<File>>([]);

  pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedPdf.value = File(result.files.first.path!);
    } else {}
  }

  pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      result.files.map((e) {
        selectedImages.value.add(File(e.path!));
      });
    } else {}
  }

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
    if (name.text.trim().isEmpty) {
      ToastManager.shared.show("Please enter name!");
      return false;
    }
    if (!mobile.text.trim().isPhoneNumber) {
      ToastManager.shared.show("Please enter valid number!");
      return false;
    }
    if (selectedItem.value == null) {
      ToastManager.shared.show("Please select a category!");
      return false;
    }
    if (address.text.trim().isEmpty) {
      ToastManager.shared.show("Please enter the address!");
      return false;
    }
    if (price.text.trim().isEmpty) {
      ToastManager.shared.show("Please enter the price!");
      return false;
    }
    if (!price.text.isNumeric) {
      ToastManager.shared.show("Please enter valid price!");
      return false;
    }
    if (beds.text.trim().isEmpty) {
      ToastManager.shared.show("Please enter bedroom count!");
      return false;
    }
    if (!beds.text.isNumeric) {
      ToastManager.shared.show("Please enter valid bedroom count!");
      return false;
    }
    if (bath.text.trim().isEmpty) {
      ToastManager.shared.show("Please enter bathroom count!");
      return false;
    }
    if (!bath.text.isNumeric) {
      ToastManager.shared.show("Please enter valid bathroom count!");
      return false;
    }
    if (sqft.text.trim().isEmpty) {
      ToastManager.shared.show("Please enter sqft!");
      return false;
    }
    if (!sqft.text.isNumeric) {
      ToastManager.shared.show("Please enter valid sqft!");
      return false;
    }
    if (description.text.trim().isEmpty) {
      ToastManager.shared.show("Please enter description!");
      return false;
    }
    if (customMarkers.value.isEmpty) {
      ToastManager.shared.show("Please pick place location on map!");
      return false;
    }
    return true;
  }
}
