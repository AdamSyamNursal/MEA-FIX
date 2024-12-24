import 'package:flutter/material.dart';
import 'package:mea/model/modeluser.dart';

class UserDetailView extends StatelessWidget {
  final UserModel user;

  UserDetailView({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengguna'),
        backgroundColor:Color(0xFFFF6F00)
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