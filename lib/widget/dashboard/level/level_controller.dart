import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LevelController extends GetxController {
  var selectedLevel = 1.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
        .collection('settings')
        .doc('level')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        selectedLevel.value = snapshot['level'] ?? 1;
      }
    });
  }

  void setLevel(int level) {
    selectedLevel.value = level;
    _saveLevelToFirebase(level);
  }

  Future<void> _saveLevelToFirebase(int level) async {
    try {
      await FirebaseFirestore.instance.collection('settings').doc('level').set({
        'level': level,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving level to Firebase: $e');
    }
  }
}
