import 'package:flutter/material.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/Services/services.dart';

class DbProvider extends ChangeNotifier {
  List<recipeModel> displayedRecipes = [];
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
      // favoriteItemsNotifier.value = favoriteItems;
    }
    notifyListeners();
  }

  Future<void> deleteFromFavourite(int index, context) async {
    await dbservice.deleteFromFavourite(index);
    favoriteItems.removeAt(index);
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

// class DbProvider extends ChangeNotifier {
//   List<recipeModel> recipeNotifier = [];
//   List<recipeModel> favoriteItemsNotifier = [];
//   DbServices dbservice = DbServices();

//   Future getAllRecipe() async {
//     recipeNotifier = await dbservice.getAllRecipesByList();
//     notifyListeners();
//   }

//   Future addRecipe(recipeModel value) async {
//     await dbservice.addRecipes(value);
//     await getAllRecipe();
//   }

//   Future deleteRecipe(int index) async {
//     await dbservice.deleteRecipes(index);
//     await getAllRecipe();
//   }

//   Future updateRecipe(recipeModel newRecipe, int index) async {
//     await dbservice.updateRecipe(index, newRecipe);
//     await getAllRecipe();
//   }

//   Future getAllFavRecipe() async {
//     favoriteItemsNotifier = await dbservice.getAllFavouriteRecipes();
//     notifyListeners();
//   }

//   // Future<void> addToFavorite(recipeModel recipe) async {
//   //   await dbservice.addToFavorite(recipe);
//   //   await getAllFavRecipe();
//   // }
//     Future<void> addToFavorite(recipeModel recipe) async {
//     final favoriteBox = await dbservice.openFavoriteBox();
//     bool isAlreadyInFavorites = favoriteItemsNotifier.contains(recipe);

//     if (!isAlreadyInFavorites) {
//       favoriteBox.add(recipe);
//       await getAllFavRecipe();
//     }
//   }

//   Future<void> deleteFromFavorite(int index) async {
//     await dbservice.deleteFromFavorite(index);
//     await getAllFavRecipe();
//   }

//   double calculateTotalCost(List<recipeModel> recipes) {
//     return dbservice.calculateTotalCost(recipes);
//   }
// }
