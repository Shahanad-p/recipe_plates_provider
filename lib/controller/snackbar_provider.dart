import 'package:flutter/material.dart';
import 'package:recipe_plates_provider/view/widget/delete_snakbar.dart';

class SnackBarProvider extends ChangeNotifier {
  void deleteRecipies(BuildContext context, int index) {
    showDeleteConfirmationDialog(context, index).then(
      (confirmed) {
        if (confirmed != null && confirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recipe deleted successfully.!'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
    );
    notifyListeners();
  }
}
