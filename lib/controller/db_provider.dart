import 'package:flutter/material.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/Services/services.dart';

class DbProvider extends ChangeNotifier {
  List<recipeModel> filtered = [];
  List<recipeModel> recipeNotifier = [];
  List<recipeModel> favoriteItems = [];
  List<recipeModel> favoriteItemsNotifier = [];
  DbServices dbservice = DbServices();

  Future getAllProvideByRecepe() async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    notifyListeners();
  }

  Future addProviderByReceipe(recipeModel value) async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    await dbservice.addRecipies(value);
    getAllProvideByRecepe();
  }

  Future deleteProviderByReceipe(int index) async {
    await dbservice.deleteRecipies(index);
    getAllProvideByRecepe();
  }

  Future updateProviderByReceipe(recipeModel newRecipe, index) async {
    await dbservice.updateRecipe(index, newRecipe);
    getAllProvideByRecepe();
  }

  Future getAllFavouriteProviderByRecipes() async {
    favoriteItems = await dbservice.getAllFavouriteRecipes();

    notifyListeners();
  }

  Future addToFavouriteProvider() async {
    recipeNotifier = List.from(recipeNotifier);
    favoriteItemsNotifier = favoriteItems;
  }

  Future<void> addToFavourite(recipeModel recipe, context) async {
    await dbservice.addToFavourite(recipe);
    bool isAlreadyInFavorites = favoriteItems.contains(recipe);
    if (!isAlreadyInFavorites) {
      favoriteItems.add(recipe);
      recipeNotifier = List.from(recipeNotifier);
    }
    notifyListeners();
  }

  Future<void> deleteFromFavourite(int index, context) async {
    await dbservice.deleteFromFavourite(index);
    favoriteItems.removeAt(index);
    notifyListeners();
  }

  void filteredRecipes(List<recipeModel> value) async {
    filtered = value;
    notifyListeners();
  }

  calculateTotalCost(List<recipeModel> recipes) {
    double totalCost = 0;
    for (int i = 0; i < recipes.length; i++) {
      recipeModel recipe = recipes[i];
      totalCost += double.parse(recipe.cost);
    }
    return totalCost;
  }
}
