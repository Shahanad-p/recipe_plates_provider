import 'package:flutter/material.dart';
import 'package:recipe_plates_provider/Model/model.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<recipeModel> displayedRecipes = [];
  TextEditingController searchController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  void int(recipeNotifier) {
    displayedRecipes = recipeNotifier;
    notifyListeners();
  }
  void edit(index, updatedRecipe) {
     displayedRecipes[index] = updatedRecipe;
    notifyListeners();
  }
}
