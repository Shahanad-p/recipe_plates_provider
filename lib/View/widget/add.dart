import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Services/services.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/View/widget/add_decorations.dart';
import 'package:recipe_plates_provider/controller/add_provider.dart';


class AddPageWidget extends StatelessWidget {
  const AddPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<AddScreenProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'New Recipe',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Form(
              key: providerData.formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _selectImageDialog(context),
                    child: _buildRecipeImage(context),
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    providerData.nameController,
                    'Name',
                    'Enter your recipe name',
                    (value) => _validateField(value, 'Name is required'),
                  ),
                  const SizedBox(height: 10),
                  _buildCategoryDropdown(context),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    providerData.descriptionController,
                    'Description',
                    'Enter your recipe description here',
                    (value) => _validateField(value, 'Description is required'),
                  ),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    providerData.ingredientsController,
                    'Ingredients',
                    'Enter your recipe ingredients',
                    (value) =>
                        _validateField(value, 'Ingredients are required'),
                  ),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    providerData.costController,
                    'Total cost',
                    'Enter your recipe total cost',
                    (value) => _validateField(value, 'Total cost is required'),
                    numericOnly: true,
                  ),
                  const SizedBox(height: 10),
                  _buildAddButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeImage(BuildContext context) {
    final providerData = Provider.of<AddScreenProvider>(context, listen: false);
    return providerData.image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(
              providerData.image!,
              height: 150,
              width: 220,
              fit: BoxFit.fill,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/2947690.jpg',
              height: 150,
              width: 220,
              fit: BoxFit.fill,
            ),
          );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String label,
    String hintText,
    FormFieldValidator<String> validator, {
    bool numericOnly = false,
  }) {
    return buildTextFormField(
      controller,
      label,
      hintText,
      80.10,
      validator,
      numericOnly: numericOnly,
    );
  }

  Widget _buildCategoryDropdown(BuildContext context) {
    final providerData = Provider.of<AddScreenProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: providerData.selectedCategory,
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
        items: providerData.categoryList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          providerData.addProvider(value);
        },
        validator: (value) => _validateField(value, 'Category is required'),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    final providerData = Provider.of<AddScreenProvider>(context, listen: false);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.amber),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      onPressed: () {
        if (providerData.formKey.currentState!.validate()) {
          addButtonClicked(context);
        } else {
          debugPrint('Please fix the errors before submitting.');
        }
      },
      child: const Text('Add all recipes'),
    );
  }

  Future<void> _selectImageDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Select Image From !',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildImageSelectionOption(
                        'assets/Animation - 1701430677440.json',
                        'Gallery',
                        () => selectedImageFromGallery(context),
                      ),
                      buildImageSelectionOption(
                        'assets/Animation - 1702530000704.json',
                        'Camera',
                        () => selectedImageFromCamera(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  selectedImageFromGallery(BuildContext context) async {
    final providerData = Provider.of<AddScreenProvider>(context, listen: false);
    _setImage(
        context,
        await providerData.imagePicker
            .pickImage(source: ImageSource.gallery, imageQuality: 10));
  }

  selectedImageFromCamera(BuildContext context) async {
    final providerData = Provider.of<AddScreenProvider>(context, listen: false);
    _setImage(
        context,
        await providerData.imagePicker
            .pickImage(source: ImageSource.camera, imageQuality: 10));
  }

  void _setImage(BuildContext context, XFile? file) {
    Provider.of<AddScreenProvider>(context, listen: false).img(file);
    Navigator.pop(context);
  }

  addButtonClicked(BuildContext context) {
    final providerData = Provider.of<AddScreenProvider>(context, listen: false);
    final name = providerData.nameController.text.trim();
    final category = providerData.selectedCategory.trim();
    final description = providerData.descriptionController.text.trim();
    final ingredients = providerData.ingredientsController.text.trim();
    final cost = providerData.costController.text.trim();

    if ([name, category, description, ingredients, cost, providerData.image]
        .any((value) => value == null || value.toString().isEmpty)) {
      debugPrint('Please fill in all fields');
      return;
    }

    final recipe = recipeModel(
      name: name,
      category: category,
      description: description,
      ingredients: ingredients,
      cost: cost,
      image: providerData.image?.path,
    );

    addRecipies(recipe);

    Navigator.of(context).pop(recipe);
    providerData.nameController.clear();
    providerData.descriptionController.clear();
    providerData.ingredientsController.clear();
    providerData.costController.clear();
    providerData.image = null;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully added new recipe.!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String? _validateField(String? value, String errorMessage) =>
      value?.isEmpty ?? true ? errorMessage : null;
}
