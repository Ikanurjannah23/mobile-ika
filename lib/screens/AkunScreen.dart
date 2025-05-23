import 'package:flutter/material.dart';

class AkunScreen extends StatelessWidget {
  final String nama = "Ika Nurjannah"; // Contoh nama
  final String nik = "3212186301050002"; // Contoh NIK
  final String jenisKelamin = "Perempuan"; // Contoh jenis kelamin
  final String email = "ikanurjannah23@gmail.com"; // Contoh email
  final String telepon = "087717649173"; // Contoh nomor telepon

  const AkunScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
        backgroundColor: const Color.fromARGB(255, 154, 10, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0), // Menambahkan padding untuk posisi box
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Agar konten dimulai dari atas
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Heading "Profil Anda"
              const Text(
                'Profil Anda',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20), // Mengurangi spasi agar box lebih dekat ke atas
              // Box berisi informasi
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 181, 179, 179),
                    width: 2.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: 300, // Lebar box
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Menyesuaikan tinggi konten
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'NIK: $nik',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Jenis Kelamin: $jenisKelamin',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Email: $email',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'No Telepon: $telepon',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30), // Spasi antara box dan tombol
              // Tombol kembali
              ElevatedButton(
                onPressed: () {
                  // Menavigasi kembali ke halaman sebelumnya (beranda)
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 154, 10, 0), // Warna tombol
                  foregroundColor: Colors.white, // Warna teks tombol menjadi putih
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  'Kembali ke Beranda',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
