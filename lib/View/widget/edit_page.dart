// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/controller/edit_provider.dart';

class EditPageWidget extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final String ingredients;
  final int index;
  final String cost;
  dynamic image;

  EditPageWidget({
    super.key,
    required this.name,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.index,
    required this.cost,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    final getProvider = Provider.of<DbProvider>(context, listen: false);
    getProvider.getAllProvideByRecepe();

    editProvider.nameController.text = name;
    editProvider.categoryController.text = category;
    editProvider.descriptionController.text = description;
    editProvider.ingredientsController.text = ingredients;
    editProvider.costController.text = cost;
    image = image != '' ? image : null;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Edit your recipes',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      editProvider.imagePicker
                          .pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 10,
                      )
                          .then((returnImage) {
                        if (returnImage != null) {
                          image = returnImage.path;
                        }
                      });
                    },
                    child: image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              image != null ? File(image!) : File(''),
                              height: 150,
                              width: 220,
                              fit: BoxFit.fill,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/restaurant-food-frame-with-rustic-wood-background-free-93.jpg',
                              height: 150,
                              width: 220,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      buildTextFormField(
                        editProvider.nameController,
                        'Name',
                        'Edit recipe name',
                        80.10,
                      ),
                      const SizedBox(height: 10),
                      buildCategoryDropdown(context),
                      const SizedBox(height: 10),
                      buildTextFormField(
                        editProvider.descriptionController,
                        'Description',
                        'Edit recipe description',
                        80.10,
                      ),
                      const SizedBox(height: 10),
                      buildTextFormField(
                        editProvider.ingredientsController,
                        'Ingredients',
                        'Edit recipe ingredients',
                        80.10,
                      ),
                      const SizedBox(height: 10),
                      buildTextFormField(
                        editProvider.costController,
                        'Total cost',
                        'Edit recipe cost',
                        80.10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.only(left: 35, right: 35),
                      ),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      recipeUpdate(context);
                    },
                    child: const Text('Update Recipes'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
    TextEditingController controller,
    String label,
    String hintText,
    double height,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
              top: Radius.circular(25),
            ),
          ),
          labelText: label,
          hintText: hintText,
          contentPadding: EdgeInsets.only(
            top: height / 2 - 16,
            bottom: height / 2 - 16,
            left: 25,
          ),
        ),
      ),
    );
  }

  Widget buildCategoryDropdown(context) {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: editProvider.selectCategory,
        itemHeight: 50.0,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
              top: Radius.circular(25),
            ),
          ),
          labelText: 'Categories',
          contentPadding: EdgeInsets.only(left: 25),
        ),
        items: editProvider.categoryList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            editProvider.selectCategory = value;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          return null;
        },
      ),
    );
  }

  Future<void> recipeUpdate(BuildContext context) async {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    final updateProviderDb = Provider.of<DbProvider>(context, listen: false);
    final name = editProvider.nameController.text.trim();
    final category = editProvider.selectCategory.trim();
    final description = editProvider.descriptionController.text.trim();
    final ingredients = editProvider.ingredientsController.text.trim();
    final cost = editProvider.costController.text.trim();

    if (name.isEmpty ||
        category.isEmpty ||
        description.isEmpty ||
        ingredients.isEmpty ||
        cost.isEmpty ||
        image == null) {
      return;
    }

    final updatedRecipe = recipeModel(
      name: name,
      category: category,
      description: description,
      ingredients: ingredients,
      cost: cost,
      image: image,
    );
    updateProviderDb.updateProviderByReceipe(updatedRecipe, index);
    Navigator.of(context).pop(updatedRecipe);
  }
}
