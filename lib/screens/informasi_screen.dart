import 'package:flutter/material.dart';
import 'package:proyek_mobile/screens/KehilanganForm.dart';
import 'package:proyek_mobile/screens/PemulaForm.dart';
import 'package:proyek_mobile/screens/RusakAtauUbahStatusForm.dart';

class InformasiScreen extends StatelessWidget {
  const InformasiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi'),
        backgroundColor: const Color.fromARGB(255, 154, 10, 0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Informasi Pengajuan KTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 154, 10, 0),
                ),
              ),
              const SizedBox(height: 32),
              _buildInfoBox(
                context,
                'Pemula',
                'Dokumen yang perlu disiapkan:\n\n1. Dokumen KK\n2. Dokumen ijazah terakhir atau surat keterangan lulus (SKL)',
                '/pemula',
              ),
              const SizedBox(height: 16),
              _buildInfoBox(
                context,
                'Kehilangan',
                'Dokumen yang perlu disiapkan:\n\n1. Dokumen KK\n2. Surat keterangan hilang dari kepolisian',
                '/kehilangan',
              ),
              const SizedBox(height: 16),
              _buildInfoBox(
                context,
                'Rusak atau Ubah Status',
                'Dokumen yang perlu dibawa:\n\n1. Dokumen KK (menyesuaikan dari KK yang sudah diperbarui)',
                '/rusak',
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoBox(BuildContext context, String title, String content, String route) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 154, 10, 0),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 127, 26, 26), // Warna konsisten
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                     
                  if(route == "/pemula") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>const PemulaForm()),
                      );
                  } else  if(route == "/kehilangan") {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>const KehilanganForm()),
                      );
                  } else  if(route == "/rusak") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>const RusakUbahStatusForm()),
                      );
                  }
                 // Navigator.pushNamed(context, route); // Navigasi ke form yang sesuai
                },
                child: const Text(
                  'isi form',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
