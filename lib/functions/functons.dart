

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/controller/db_provider.dart';

// ValueNotifier<List<recipeModel>> recipeNotifier = ValueNotifier([]);
// List<recipeModel> favoriteItems = [];
// ValueNotifier<List<recipeModel>> favoriteItemsNotifier =
//     ValueNotifier<List<recipeModel>>([]);
///////////////////////////////////////////////////////
// Future<void> addRecipies(recipeModel value) async {
//   final recipedb = await Hive.openBox<recipeModel>('recipe_db');
//   recipedb.add(value);
//   recipeNotifier.value.add(value);
//   recipeNotifier.notifyListeners();
// }
///////////////////////////////////////////////////

// Future<void> getAllRecipiesByList() async {
//   final recipedb = await Hive.openBox<recipeModel>('recipe_db');
//   recipeNotifier.value.clear();
//   recipeNotifier.value.addAll(recipedb.values);
//   recipeNotifier.notifyListeners();
// }

////////////////////////////////////////////
// Future<void> deleteRecipies(int index) async {
//   final recipedb = await Hive.openBox<recipeModel>('recipe_db');
//   recipedb.deleteAt(index);
//   getAllRecipiesByList();
// }
//////////////////////////////////////////////
// Future<void> updateRecipe(int index, recipeModel newRecipe) async {
//   Hive.initFlutter();
//   final recipeDB = await Hive.openBox<recipeModel>('recipies_db');
//   if (index >= 0 && index < recipeDB.length) {
//     recipeDB.putAt(index, newRecipe);
//     getAllRecipiesByList();
//   }
// }
//////////////////////////////////////////////////////////////////////
// Future<void> updateRecipe(int index, recipeModel newRecipe) async {
//   Hive.initFlutter();
//   final recipeDB = await Hive.openBox<recipeModel>('recipies_db');
//   recipeDB.putAt(index, newRecipe);
//   getAllRecipiesByList();
// }
///////////////////////////////////////////////////////////////////////
// Future<void> getAllFavouriteRecipes() async {
//   final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
//   final favoriteItems = favoriteBox.values.toList();
//   favoriteItemsNotifier.value = favoriteItems;
// }

// Future<void> addToFavourite(recipeModel recipe, context) async {
//   final dbprv = Provider.of<DbProvider>(context, listen: false);
//   final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
//   bool isAlreadyInFavorites = favoriteItems.contains(recipe);
//   if (!isAlreadyInFavorites) {
//     favoriteBox.add(recipe);
//     dbprv.recipeNotifier = List.from(dbprv.recipeNotifier);
//     favoriteItemsNotifier.value = favoriteItems;
//   }
// }

// Future<void> deleteFromFavourite(int index, context) async {
//   final dbprv = Provider.of<DbProvider>(context, listen: false);
//   final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
//   favoriteBox.deleteAt(index);
//   favoriteItems.removeAt(index);
//   dbprv.recipeNotifier = List.from(dbprv.recipeNotifier);
//   favoriteItemsNotifier.value = favoriteItems;
//   favoriteItemsNotifier.value = favoriteBox.values.toList();
// }
