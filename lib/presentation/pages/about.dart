import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Stack(
              children: [
                Container(
                  color: Colors.blue,
                  height: 200,
                  width: double.infinity,
                ),
                const Positioned(
                  left: 16,
                  bottom: 16,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          'assets/profile.jpg', // Placeholder image
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Andrew',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Profile Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileItem('Nama', 'Andrew'),
                  _buildProfileItem('Email', 'andrew@example.com'),
                  _buildProfileItem('No Telepon', '+62 81234567890'),
                  _buildProfileItem('Tanggal Lahir', '01 Januari 1990'),
                  _buildProfileItem('Alamat', 'Jl. Merdeka No. 123, Jakarta'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for each profile item
  Widget _buildProfileItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
        const Divider(height: 24, thickness: 1),
      ],
    );
  }
}
