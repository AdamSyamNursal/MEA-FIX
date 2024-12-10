import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class lokasigambar extends StatelessWidget {
  final String kecamatan;
  final String kelurahan;
  final Timestamp time;

  lokasigambar({
    required this.kecamatan,
    required this.kelurahan,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = "${time.toDate().day}/${time.toDate().month}/${time.toDate().year}";

    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Icon with slight padding for better alignment
            Image.asset(
              'assets/icons/destination.png',
              width: 28,
              height: 28,
            ),
            SizedBox(width: 8), // Add spacing between icon and text
            // Location and date information
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$kelurahan, $kecamatan",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4), // Add spacing between location and date
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
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
