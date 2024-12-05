import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RekomendasiText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('recommendations')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get()
            .then((snapshot) => snapshot.docs.first),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading recommendations",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text("No recommendations available"),
            );
          }

          // Retrieve recommendations list from Firebase
          List<dynamic> recommendations =
              snapshot.data!.get('recommendations') ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recommendations.asMap().entries.map((entry) {
              int index = entry.key;
              String recommendation = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "${index + 1}. $recommendation",
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
