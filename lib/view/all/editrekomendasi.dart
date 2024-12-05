import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Viewedit extends StatefulWidget {
  @override
  _ViewEditState createState() => _ViewEditState();
}

class _ViewEditState extends State<Viewedit> {
  List<TextEditingController> _controllers = []; // Untuk mengelola input rekomendasi

  @override
  void initState() {
    super.initState();
    _addRecommendationField(); // Tambahkan satu field default
  }

  void _addRecommendationField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  Future<void> _saveRecommendationsToFirebase() async {
    try {
      List<String> recommendations = _controllers.map((controller) => controller.text).toList();

      // Simpan ke Firestore
      await FirebaseFirestore.instance.collection('recommendations').add({
        'recommendations': recommendations,
        'timestamp': Timestamp.now(),
      });

      Get.snackbar(
        "Success",
        "Recommendations saved successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Reset form
      setState(() {
        _controllers.clear();
        _addRecommendationField();
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save recommendations: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Recommendations"),
        backgroundColor: Color(0xFFFF6F00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        labelText: "Recommendation ${index + 1}",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _addRecommendationField,
                  icon: Icon(Icons.add),
                  label: Text("Add More"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6F00),
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveRecommendationsToFirebase,
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
