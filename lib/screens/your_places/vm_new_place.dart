import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:real_estate/model/m_place.dart';
import 'package:real_estate/utils/manager/toast_manager.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../model/m_category.dart';
import '../../utils/c_extensions.dart';
import '../../utils/manager/color_manager.dart';
import '../../utils/manager/font_manager.dart';
import '../../utils/manager/loading_manager.dart';
import '../textbox/vm_textbox.dart';

class VMNewPlace extends GetxController {
  Rx<List<Marker>> customMarkers = Rx([]);
  Rxn<File> selectedPdf = Rxn<File>();
  Rx<List<File>> selectedImages = Rx<List<File>>([]);
  Position? currentLocation;

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
      allowMultiple: true,
    );
    if (result != null) {
      for (var e in result.files) {
        selectedImages.value.insert(0, File(e.path!));
      }
      selectedImages.refresh();
    } else {}
  }

  reOrderImage(oldIndex, newIndex) {
    File removedFile = selectedImages.value.removeAt(oldIndex);
    selectedImages.value.insert(newIndex, removedFile);
    selectedImages.refresh();
  }

  removeImage(index) {
    selectedImages.value.removeAt(index);
    selectedImages.refresh();
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
    if (name.text
        .trim()
        .isEmpty) {
      ToastManager.shared.show("Please enter name!");
      return false;
    }
    if (!mobile.text
        .trim()
        .isPhoneNumber) {
      ToastManager.shared.show("Please enter valid number!");
      return false;
    }
    if (selectedItem.value == null) {
      ToastManager.shared.show("Please select a category!");
      return false;
    }
    if (address.text
        .trim()
        .isEmpty) {
      ToastManager.shared.show("Please enter the address!");
      return false;
    }
    if (price.text
        .trim()
        .isEmpty) {
      ToastManager.shared.show("Please enter the price!");
      return false;
    }
    if (!price.text.isNumeric) {
      ToastManager.shared.show("Please enter valid price!");
      return false;
    }
    if (beds.text
        .trim()
        .isEmpty) {
      ToastManager.shared.show("Please enter bedroom count!");
      return false;
    }
    if (!beds.text.isNumeric) {
      ToastManager.shared.show("Please enter valid bedroom count!");
      return false;
    }
    if (bath.text
        .trim()
        .isEmpty) {
      ToastManager.shared.show("Please enter bathroom count!");
      return false;
    }
    if (!bath.text.isNumeric) {
      ToastManager.shared.show("Please enter valid bathroom count!");
      return false;
    }
    if (sqft.text
        .trim()
        .isEmpty) {
      ToastManager.shared.show("Please enter sqft!");
      return false;
    }
    if (!sqft.text.isNumeric) {
      ToastManager.shared.show("Please enter valid sqft!");
      return false;
    }
    if (selectedPdf.value == null) {
      ToastManager.shared.show("Please select land document for validation!");
      return false;
    }
    if (selectedImages.value.isEmpty) {
      ToastManager.shared.show("Please select place images!");
      return false;
    }
    if (description.text
        .trim()
        .isEmpty) {
      ToastManager.shared.show("Please enter description!");
      return false;
    }
    if (customMarkers.value.isEmpty) {
      ToastManager.shared.show("Please pick place location on map!");
      return false;
    }
    return true;
  }

  showAlert(context) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: getCustomFont(
              "Reason for rejection!",
              18,
              Colors.redAccent,
              1,
              fontWeight: bold,
            ),
            content: SingleChildScrollView(
              child: getCustomFont(
                "Lorem Ipsum is simply dummy unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                14,
                darkGrey,
                1000,
                fontWeight: semiBold,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
    );
  }

  storePlaceDate(bool isForSale) async {
    if (!validate()) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    var randomDoc = FirebaseFirestore.instance.collection("places").doc();


    LoadingManager.shared.showLoading();

    try {
      String? url = await uploadDocument(randomDoc.id);
      if (url != null) {
        List<String> urls = await uploadImages(randomDoc.id);

        if (urls.isNotEmpty) {
          PlaceModel placeModel = PlaceModel(
            userId: user?.uid,
            placeId: randomDoc.id,
            name: name.text,
            mobile: mobile.text,
            categoryId: selectedItem.value!.id,
            address: address.text,
            price: price.text,
            isForSale: isForSale,
            beds: beds.text,
            bath: bath.text,
            sqft: sqft.text,
            documentUrl: url,
            imagesUrl: urls,
            description: description.text,
            latitude: customMarkers.value.first.point.latitude,
            longitude: customMarkers.value.first.point.longitude,
            createdAt: Timestamp.now(),
          );

          randomDoc.set(
            placeModel.toJson(),
          );

          Get.back();
        }
      }
    } catch (e) {
      print(e);
      ToastManager.shared.show("Failed to create place!");
    } finally {
      LoadingManager.shared.hideLoading();
    }
  }

  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ToastManager.shared.show("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ToastManager.shared.show("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ToastManager.shared.show(
          "Location permissions are permanently denied, we cannot request permissions.");
    }

    currentLocation = await Geolocator.getCurrentPosition();
    print(currentLocation);
  }

  Future<List<String>> uploadImages(documentId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      List<String> downloadUrls = [];
      ToastManager.shared.show("Uploading images");

      for (var element in selectedImages.value) {
        Reference storageReference = FirebaseStorage.instance.ref().child(
            'places/${user?.uid}/$documentId/${selectedImages.value.indexOf(
                element)}.png');
        UploadTask uploadTask = storageReference.putFile(element);
        await uploadTask.whenComplete(() async {
          String imageUrl = await storageReference.getDownloadURL();
          downloadUrls.add(imageUrl);
          print('Image URL: $imageUrl');
        });
      }

      return downloadUrls;
    } catch (e) {
      ToastManager.shared.show("Failed to upload images!");
      print('Error uploading image: $e');
      return [];
    }
  }

  Future<String?> uploadDocument(documentId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      String? url;
      ToastManager.shared.show("Uploading land document");

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('places/${user?.uid}/$documentId/land-document.pdf');
      UploadTask uploadTask = storageReference.putFile(selectedPdf.value!);
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();
        url = imageUrl;
        print('Image URL: $imageUrl');
      });
      return url;
    } catch (e) {
      ToastManager.shared.show("Failed to upload land document!");
      print('Error uploading image: $e');
      return null;
    }
  }
}
