import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';

class HomeScreenProvider extends ChangeNotifier {
  String search = '';
  List<recipeModel> displayedRecipes = [];
  TextEditingController searchController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  void searchResult(context) {
    final dbpro = Provider.of<DbProvider>(context, listen: false);
    final filteredRecipies = dbpro.recipeNotifier
        .where((recipeList) =>
            recipeList.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
    dbpro.filteredRecipes(filteredRecipies);
    notifyListeners();
  }
}
