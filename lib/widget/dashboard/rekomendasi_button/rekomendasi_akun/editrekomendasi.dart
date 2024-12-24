import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ViewEditController extends GetxController {
  var controllers = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    addRecommendationField(); // Tambahkan satu field default
  }

  void addRecommendationField() {
    controllers.add(TextEditingController());
  }

  Future<void> saveRecommendationsToFirebase() async {
    try {
      List<String> recommendations =
          controllers.map((controller) => controller.text).toList();

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
      controllers.clear();
      addRecommendationField();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save recommendations: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

class ViewEdit extends StatelessWidget {
  final ViewEditController controller = Get.put(ViewEditController());

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
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.controllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: controller.controllers[index],
                        decoration: InputDecoration(
                          labelText: "Recommendation ${index + 1}",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: controller.addRecommendationField,
                  icon: Icon(Icons.add),
                  label: Text("Add More"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6F00),
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.saveRecommendationsToFirebase,
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
