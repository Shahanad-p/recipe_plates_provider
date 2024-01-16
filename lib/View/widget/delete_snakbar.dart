import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/controller/db_provider.dart';

Future<bool?> showDeleteConfirmationDialog(
    BuildContext context, int index) async {
  final deleteProviderDb = Provider.of<DbProvider>(context, listen: false);
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const Text(
                'Are you sure? you want to delete this recipe?',
                style: TextStyle(fontSize: 18),
              ),
              Lottie.asset('assets/Animation - 1702529005450.json', height: 60),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            onPressed: () {
              deleteProviderDb.deleteProviderByReceipe(index);
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    },
  );
}
