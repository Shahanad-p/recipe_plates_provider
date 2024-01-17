import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProvider extends ChangeNotifier {
  final imagePicker = ImagePicker();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredientsController = TextEditingController();
  final costController = TextEditingController();
  String? image;
  String selectCategory = 'Beverages';
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
}
