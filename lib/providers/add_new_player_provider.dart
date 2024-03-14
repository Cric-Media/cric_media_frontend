// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cricket_app/apis_servies/api_servies.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/add_new_player_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPlayerProvider extends ChangeNotifier {
  ApiServies services = ApiServies();

  final playerNameController = TextEditingController();
  final playerLocation = TextEditingController();
  final playerType = TextEditingController();
  final playerAge = TextEditingController();
  final playerInformation = TextEditingController();

  String _selectedBookingFor = 'boller';
  XFile? _pickedImage;
  final ImagePicker _imagePicker = ImagePicker();

  String get selectedBookingFor => _selectedBookingFor;

  set selectedBookingFor(String value) {
    _selectedBookingFor = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  String get pickedImagePath => _pickedImage?.path ?? "";

  Future<void> pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    _pickedImage = pickedImage;
    notifyListeners();
  }

  Future<String?> convertImageToBase64(String imagePath) async {
    try {
      File imageFile = File(imagePath);
      Uint8List imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } catch (e) {
      print("Error converting image to base64: $e");
      return null;
    }
  }

  Future<void> addNewPlayerMethod(BuildContext context) async {
    setLoading(true);
    final id = await Global().getUserId();
    int? userId = int.tryParse(id.toString());

    int? age = int.tryParse(playerAge.text);
    if (age == null) {
      print('Invalid age format');
      setLoading(false);
      return;
    }

    if (_pickedImage == null) {
      print('No image selected');
      setLoading(false);
      return;
    }

    String? base64Image = await convertImageToBase64(_pickedImage!.path);
    if (base64Image == null) {
      print('Failed to convert image to base64');
      setLoading(false);

      return;
    }

    AddNewPlayerModel addNewPlayerModel = AddNewPlayerModel(
      created_by: userId!,
      image: base64Image,
      type: _selectedBookingFor,
      age: age,
      name: playerNameController.text,
      additional_information: playerInformation.text,
      location: playerLocation.text,
    );

    print("  image url ====>>>$base64Image");

    print('pickage froma gallery===>>>>$pickedImagePath');
    try {
      final AddNewPlayerModel? result =
          await services.addNewPlayer(addNewPlayerModel, context);

      setLoading(true);
      if (result != null) {
        print('Player has been successfully added.');
      } else {
        setLoading(false);
        print('Failed to add player.');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      setLoading(false);
    }
    notifyListeners();
  }
}
