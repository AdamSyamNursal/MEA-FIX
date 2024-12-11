import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/model/modeluser.dart';

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
        title: Text('Daftar Pengguna'),
        backgroundColor: Colors.orange,
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

class UserDetailView extends StatelessWidget {
  final UserModel user;

  UserDetailView({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengguna'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: ${user.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
            Text('Username: ${user.username}', style: TextStyle(fontSize: 16)),
            Text('Role: ${user.role}', style: TextStyle(fontSize: 16)),
            Text('Nomor Telepon: ${user.phoneNumber}', style: TextStyle(fontSize: 16)),
            Text('Alamat: ${user.address}', style: TextStyle(fontSize: 16)),
            Text('Tanggal Lahir: ${user.dateOfBirth}', style: TextStyle(fontSize: 16)),
            Text('Tanggal Registrasi: ${user.registrationDate}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Status ACC: ', style: TextStyle(fontSize: 16)),
                Icon(
                  user.acc ? Icons.check_circle : Icons.cancel,
                  color: user.acc ? Colors.green : Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
