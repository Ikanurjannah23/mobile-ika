import 'package:flutter/material.dart';
import 'package:proyek_mobile/screens/ResumeScreen.dart';
import 'ResumeScreen.dart';// Make sure to import ResumeScreen

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pengajuan'),
        backgroundColor: const Color.fromARGB(255, 155, 10, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pengajuan',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 154, 10, 0),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildSubmissionCard(
                    context,
                    '001',
                    'pemula',
                    '087717649173',
                    'ika nurjannah',
                    '2024-12-10',
                    'Sedang Diproses',
                  ),
                  _buildSubmissionCard(
                    context,
                    '002',
                    'Rusak atau Ubah Status',
                    '082126701869',
                    'Tiara Ainul Zannah',
                    '2024-12-09',
                    'Selesai',
                  ),
                  _buildSubmissionCard(
                    context,
                    '003',
                    'Kehilangan',
                    '085861236439',
                    'Nadiya Zarah Islamiati',
                    '2024-12-08',
                    'Ditolak',
                  ),
                  _buildSubmissionCard(
                    context,
                    '004',
                    'pemula',
                    '085861236439',
                     'Nadiya Zarah',
                     '2024-12-23',
                     'Sedang Diproses',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmissionCard(
    BuildContext context,
    String noAntrean,
    String jenisKTP,
    String nik,
    String nama,
    String tanggalPengajuan,
    String status,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No. Antrean: $noAntrean',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 155, 10, 0),
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow('Jenis KTP', jenisKTP, Icons.credit_card),
            _buildInfoRow('NIK', nik, Icons.perm_identity),
            _buildInfoRow('Nama', nama, Icons.person),
            _buildInfoRow('Tanggal Pengajuan', tanggalPengajuan, Icons.calendar_today),
            _buildInfoRow('Status', status, Icons.check_circle),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to ResumeScreen with data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumeScreen(
                        jenisKTP: jenisKTP,
                        nik: nik,
                        nama: nama,
                        alamat: 'Alamat Lengkap', // Example placeholder
                        tanggal: tanggalPengajuan,
                        telepon: '123-456-7890', // Example placeholder
                      ),
                    ),
                  );
                },
                child: const Text('Lihat Resume'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 154, 10, 0),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 154, 10, 0),
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '$title: $content',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
