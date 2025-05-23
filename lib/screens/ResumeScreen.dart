import 'package:flutter/material.dart';
import 'dart:io';

class ResumeScreen extends StatelessWidget {
  final String jenisKTP;
  final String nik;
  final String nama;
  final String alamat;
  final String tanggal;
  final String telepon;
  final File? imageKK;
  final File? imageIjazah;

  const ResumeScreen({
    Key? key,
    required this.jenisKTP,
    required this.nik,
    required this.nama,
    required this.alamat,
    required this.tanggal,
    required this.telepon,
    this.imageKK,
    this.imageIjazah,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Pengajuan'),
        backgroundColor: const Color.fromARGB(255, 150, 0, 0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Text(
                    'Detail Pengajuan KTP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 161, 5, 5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: const Color.fromARGB(255, 165, 13, 13), thickness: 2),

                // Jenis KTP
                _buildInfoCard(
                  title: 'Jenis KTP',
                  content: jenisKTP,
                  icon: Icons.credit_card,
                ),

                // NIK
                _buildInfoCard(
                  title: 'NIK',
                  content: nik,
                  icon: Icons.perm_identity,
                ),

                // Nama
                _buildInfoCard(
                  title: 'Nama Lengkap',
                  content: nama,
                  icon: Icons.person,
                ),

                // Alamat
                _buildInfoCard(
                  title: 'Alamat',
                  content: alamat,
                  icon: Icons.location_on,
                ),

                // Tanggal Pengajuan
                _buildInfoCard(
                  title: 'Tanggal Pengajuan',
                  content: tanggal,
                  icon: Icons.calendar_today,
                ),

                // Telepon
                _buildInfoCard(
                  title: 'Nomor Telepon',
                  content: telepon,
                  icon: Icons.phone,
                ),

                const SizedBox(height: 20),
                Divider(color: const Color.fromARGB(255, 173, 23, 23), thickness: 2),
                const SizedBox(height: 20),

               
              

                // Button Kembali
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat Card informasi
  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          child: Icon(icon, color: const Color.fromARGB(255, 152, 29, 29)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(content),
      ),
    );
  }
}
