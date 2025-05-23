import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'ResumeScreen.dart'; // Import file ResumeScreen

class KehilanganForm extends StatefulWidget {
  const KehilanganForm({Key? key}) : super(key: key);

  @override
  State<KehilanganForm> createState() => _KehilanganFormState();
}

class _KehilanganFormState extends State<KehilanganForm> {
  final _formKey = GlobalKey<FormState>();
  File? _imageKK;
  File? _imageKehilangan;
  String? _selectedJenisKTP;
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _teleponController = TextEditingController();

  Future<void> _selectImage(ImageSource source, String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (type == 'KK') {
          _imageKK = File(pickedFile.path);
        } else if (type == 'Kehilangan') {
          _imageKehilangan = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Kehilangan'),
        backgroundColor: const Color.fromARGB(255, 150, 0, 0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Formulir Pengajuan KTP Kehilangan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 138, 8, 8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dropdown Jenis KTP
                    DropdownButtonFormField<String>(
                      value: _selectedJenisKTP,
                      decoration: const InputDecoration(
                        labelText: 'Jenis KTP',
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Pilih Jenis KTP'),
                      items: ['Pemula', 'Kehilangan', 'Rusak atau Ubah Status']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedJenisKTP = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis KTP harus dipilih';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // NIK
                    TextFormField(
                      controller: _nikController,
                      decoration: const InputDecoration(
                        labelText: 'NIK',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NIK harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nama Lengkap
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama lengkap harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Alamat
                    TextFormField(
                      controller: _alamatController,
                      decoration: const InputDecoration(
                        labelText: 'Alamat Lengkap',
                        hintText: 'Contoh: Jl. Raya No. 10, Jakarta',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.home),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Alamat harus diisi';
                        }
                        return null;
                      },
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // Tanggal Pengajuan
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _tanggalController,
                          decoration: const InputDecoration(
                            labelText: 'Hari Tanggal Pengajuan',
                            hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal pengajuan harus diisi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // No Telepon
                    TextFormField(
                      controller: _teleponController,
                      decoration: const InputDecoration(
                        labelText: 'No Telepon',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'No Telepon harus diisi';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Foto KK
              OutlinedButton.icon(
                onPressed: () => _selectImage(ImageSource.gallery, 'KK'),
                icon: const Icon(Icons.image),
                label: const Text('Pilih Foto KK'),
              ),
              const SizedBox(height: 8),
              _imageKK == null
                  ? const Text('Belum ada foto KK yang dipilih.')
                  : Image.file(_imageKK!),
              const SizedBox(height: 16),

              // Foto Kehilangan
              OutlinedButton.icon(
                onPressed: () =>
                    _selectImage(ImageSource.gallery, 'Kehilangan'),
                icon: const Icon(Icons.image),
                label: const Text('Pilih Foto Surat Kehilangan'),
              ),
              const SizedBox(height: 8),
              _imageKehilangan == null
                  ? const Text('Belum ada foto surat kehilangan yang dipilih.')
                  : Image.file(_imageKehilangan!),
              const SizedBox(height: 16),

              // Kirim Pengajuan Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResumeScreen(
                            jenisKTP: _selectedJenisKTP!,
                            nik: _nikController.text,
                            nama: _namaController.text,
                            alamat: _alamatController.text,
                            tanggal: _tanggalController.text,
                            telepon: _teleponController.text,
                            imageKK: _imageKK,
                            imageIjazah: _imageKehilangan,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                  ),
                  child: const Text(
                    'Kirim Pengajuan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
