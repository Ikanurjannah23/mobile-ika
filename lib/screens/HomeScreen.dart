import 'package:flutter/material.dart';
import 'package:proyek_mobile/screens/AkunScreen.dart';
import 'package:proyek_mobile/screens/LoginScreen.dart';
import 'PemulaForm.dart';
import 'KehilanganForm.dart';
import 'RusakAtauUbahStatusForm.dart';
import 'informasi_screen.dart';
import 'StatusScreen.dart';
import 'AkunScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showPengajuanBoxes = false;
  bool _showPemulaForm = false;
  bool _showKehilanganForm = false;
  bool _showRusakAtauUbahStatusForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        'Reg-',
        style: TextStyle(fontSize: 20),
      ),
      const SizedBox(width: 5),
      Icon(
        Icons.power_settings_new, // Ikon power dari Flutter
        size: 20,
        color: const Color.from(alpha: 1, red: 0.008, green: 0.008, blue: 0.008), // Warna ikon mengikuti warna teks
      ),
      const SizedBox(width: 5),
      const Text(
        'N',
        style: TextStyle(fontSize: 20),
      ),
    ],
  ),
  backgroundColor: const Color.fromARGB(255, 155, 10, 0),
),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 154, 10, 0),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Pengajuan'),
              onTap: () {
                setState(() {
                  _showPengajuanBoxes = true;
                  _showPemulaForm = false;
                  _showKehilanganForm = false;
                  _showRusakAtauUbahStatusForm = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Informasi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InformasiScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Status'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StatusScreen()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status')),
                );
              },
            ), ListTile(
               title: const Text('akun'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AkunScreen()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('akun')),
                );
              },
            ),ListTile(
              title: const Text('Keluar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: _showPengajuanBoxes
          ? _buildPengajuanOptions(context)
          : _buildHomeGrid(context),
    );
  }

 Widget _buildHomeGrid(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min, // Ukuran kolom hanya sesuai konten
      mainAxisAlignment: MainAxisAlignment.center, // Elemen berada di tengah
      children: [
        // Paragraf "Selamat Datang"
        Text(
          'Reg-on merupakan sebuah website yang digunakan untuk pendaftaran pengajuan dokumen KTP secara online di kecamatan lohbener',
          textAlign: TextAlign.center, // Paragraf di tengah
          style: const TextStyle(
            fontSize: 18, // Ukuran font
            fontWeight: FontWeight.bold,
            color: Colors.black, // Warna teks
          ),
        ),
        const SizedBox(height: 24), // Jarak antara teks dan kotak pertama
        _buildHomeBox(context, 'Pengajuan'),
        const SizedBox(height: 16), // Jarak antar kotak
        _buildHomeBox(context, 'Informasi'),
        const SizedBox(height: 16), // Jarak antar kotak
        _buildHomeBox(context, 'Status'),
      ],
    ),
  );
}
Widget _buildHomeBox(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      if (title == 'Pengajuan') {
        setState(() {
          _showPengajuanBoxes = true;
        });
      } else if (title == 'Informasi') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InformasiScreen()),
        );
      } else if (title == 'Status') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StatusScreen()),
        );
      }else if (title == 'akun') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StatusScreen()),
        ); 
      }
    },
    child: SizedBox(
      width: 200, // Lebar kotak
      height: 100, // Tinggi kotak
      child: Card(
        color: const Color.fromARGB(255, 154, 10, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Sudut melengkung
        ),
        elevation: 2, // Shadow lebih kecil
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


  Widget _buildPengajuanOptions(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pengajuan KTP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 154, 10, 0),
              ),
            ),
            const SizedBox(height: 16),
            _buildOptionBox(context, 'Pemula'),
            const SizedBox(height: 16),
            _buildOptionBox(context, 'Kehilangan'),
            const SizedBox(height: 16),
            _buildOptionBox(context, 'Rusak atau Ubah Status'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showPengajuanBoxes = false;
                });
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionBox(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pemula') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PemulaForm()),
          );
        } else if (title == 'Kehilangan') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KehilanganForm()),
          );
        } else if (title == 'Rusak atau Ubah Status') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RusakUbahStatusForm()),
          );
        }
      },
      child: Card(
        color: const Color.fromARGB(255, 154, 10, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
