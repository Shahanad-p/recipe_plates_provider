import 'package:hive_flutter/adapters.dart';
import 'package:recipe_plates_provider/Model/model.dart';

class DbServices {
  addRecipies(recipeModel value) async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
    return recipedb.add(value);
  }

  getAllRecipiesByList() async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
    return recipedb.values.toList();
  }

  deleteRecipies(int index) async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
    recipedb.deleteAt(index);
  }

  getAllFavouriteRecipes() async {
    final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
    return favoriteBox.values.toList();
  }

  addToFavourite(recipeModel recipe) async {
    final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');

    return favoriteBox.add(recipe);
  }

  deleteFromFavourite(int index) async {
    final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
    favoriteBox.deleteAt(index);
  }
}
