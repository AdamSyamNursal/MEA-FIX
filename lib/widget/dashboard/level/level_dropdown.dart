import 'package:flutter/material.dart';
import 'package:mea/widget/dashboard/level/level_controller.dart';

class LevelDropdown extends StatelessWidget {
  final LevelController levelController;

  LevelDropdown({required this.levelController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Pilih Level"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Level 1 (Normal)"),
            onTap: () {
              levelController.setLevel(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Level 2 (Waspada)"),
            onTap: () {
              levelController.setLevel(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Level 3 (Siaga)"),
            onTap: () {
              levelController.setLevel(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Level 4 (Awas)"),
            onTap: () {
              levelController.setLevel(4);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
