// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/controller/edit_provider.dart';

class EditPageWidget extends StatefulWidget {
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
  State<EditPageWidget> createState() => _EditPageWidgetState();
}

class _EditPageWidgetState extends State<EditPageWidget> {
  @override
  void initState() {
    final getProvider = Provider.of<DbProvider>(context, listen: false);
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    super.initState();
    getProvider.getAllProvideByRecepe();

    editProvider.nameController.text = widget.name;
    editProvider.categoryController.text = widget.category;
    editProvider.descriptionController.text = widget.description;
    editProvider.ingredientsController.text = widget.ingredients;
    editProvider.costController.text = widget.cost;
    editProvider.image = widget.image != '' ? widget.image : null;
  }

  @override
  Widget build(BuildContext context) {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.08, vertical: 20.08),
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final returnImage =
                          await editProvider.imagePicker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 10,
                      );
                      if (returnImage != null) {
                        editProvider.edit(returnImage.path);
                      }
                    },
                    child: Consumer<EditProvider>(
                      builder: (context, value, child) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15.08),
                          child: Image.file(
                            value.image != null ? File(value.image!) : File(''),
                            height: 150,
                            width: 220,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
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
                      buildCategoryDropdown(),
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
                      backgroundColor: MaterialStateProperty.all(Colors.green),
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

  Widget buildCategoryDropdown() {
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
            setState(() {
              editProvider.selectCategory = value;
            });
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
    final getProvider = Provider.of<DbProvider>(context, listen: false);
    final editProvider = Provider.of<EditProvider>(context, listen: false);
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
        editProvider.image == null) {
      return;
    }

    final updatedRecipe = recipeModel(
      name: name,
      category: category,
      description: description,
      ingredients: ingredients,
      cost: cost,
      image: editProvider.image,
    );
    getProvider.updateProviderByReceipe(updatedRecipe, widget.index);
    Navigator.of(context).pop(updatedRecipe);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your recipe updated successfully!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
