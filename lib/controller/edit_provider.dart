import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_plates_provider/Model/model.dart';

class EditProvider extends ChangeNotifier {
  List<RecipeModel> displayedRecipes = [];
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

  void edit(imagePath) {
    image = imagePath;
    notifyListeners();
  }
}
