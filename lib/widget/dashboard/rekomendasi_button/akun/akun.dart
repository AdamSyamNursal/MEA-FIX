import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/model/modeluser.dart';
import 'package:mea/widget/dashboard/rekomendasi_button/akun/userdetailview.dart';

class UserListView extends StatelessWidget {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Fungsi untuk memperbarui nilai `acc` pada Firestore
  Future<void> _updateUserAcc(String userId, bool acc) async {
    await usersCollection.doc(userId).update({'acc': acc});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengguna', style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(
    color: Colors.white, // Ganti warna ikon back sesuai kebutuhan
  ),
        backgroundColor: Color(0xFFFF6F00)
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada pengguna yang ditemukan.'));
          }

          final users = snapshot.data!.docs.map((doc) {
            return UserModel.fromJson(
              doc.data() as Map<String, dynamic>,
              doc.id, // Kirim id dari dokumen ke model
            );
          }).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${user.email}'),
                      Text('Role: ${user.role}'),
                    ],
                  ),
                  trailing: Switch(
                    value: user.acc,
                    onChanged: (value) {
                      _updateUserAcc(user.id, value);
                    },
                  ),
                  onTap: () {
                    // Navigasi ke halaman detail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailView(user: user),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


