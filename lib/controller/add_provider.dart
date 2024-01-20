import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddScreenProvider extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredientsController = TextEditingController();
  final costController = TextEditingController();
  File? image;
  final formKey = GlobalKey<FormState>();
  String selectedCategory = 'Beverages';
  final List<String> categoryList = [
    'Beverages',
    'Fastfood',
    'Salads',
    'Desserts',
    'Healthy',
    'Grilled',
    'Snacks',
    'Soup'
  ];
  
  void addProvider(value) {
    if (value != null) {
      selectedCategory = value;
    }
    notifyListeners();
  }

  void imageProvider(file) {
    if (file != null) {
      image = File(file.path);
    }
    notifyListeners();
  }
}
