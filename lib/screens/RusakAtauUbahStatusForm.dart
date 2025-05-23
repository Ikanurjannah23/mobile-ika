import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'ResumeScreen.dart';  // Pastikan Anda mengimpor halaman ResumeScreen

class RusakUbahStatusForm extends StatefulWidget {
  const RusakUbahStatusForm({Key? key}) : super(key: key);

  @override
  State<RusakUbahStatusForm> createState() => _RusakUbahStatusFormState();
}

class _RusakUbahStatusFormState extends State<RusakUbahStatusForm> {
  final _formKey = GlobalKey<FormState>();
  File? _imageKK;
  String? _selectedJenisKTP;
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  // Fungsi untuk memilih gambar KK
  Future<void> _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageKK = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk navigasi ke ResumeScreen
  void _navigateToResume() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumeScreen(
            jenisKTP: _selectedJenisKTP ?? '',
            nik: _nikController.text,
            nama: _nameController.text,
            alamat: _alamatController.text,
            tanggal: _tanggalController.text,
            telepon: _phoneController.text,
            imageKK: _imageKK,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Rusak/Ubah Status'),
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
                  color: const Color.fromARGB(255, 250, 250, 250),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Formulir Rusak/Ubah Status KTP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 138, 8, 8),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Jenis KTP Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedJenisKTP,
                      decoration: const InputDecoration(
                        labelText: 'Jenis KTP',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      hint: const Text('Pilih Jenis KTP'),
                      items: <String>[
                        'Pemula',
                        'Kehilangan',
                        'Rusak atau Ubah Status'
                      ].map((String value) {
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
                        filled: true,
                        fillColor: Colors.white,
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
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
                        filled: true,
                        fillColor: Colors.white,
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
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            _tanggalController.text =
                                "${picked.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _tanggalController,
                          decoration: const InputDecoration(
                            labelText: 'Hari Tanggal Pengajuan',
                            hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                            filled: true,
                            fillColor: Colors.white,
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
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'No Telepon',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                        filled: true,
                        fillColor: Colors.white,
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

              // Unggah Foto KK
              OutlinedButton.icon(
                onPressed: () => _selectImage(ImageSource.gallery),
                icon: const Icon(Icons.image),
                label: const Text('Pilih Foto KK'),
              ),
              const SizedBox(height: 8),
              _imageKK == null
                  ? const Text('No image selected for KK.')
                  : Image.file(_imageKK!),
              const SizedBox(height: 16),

              // Kirim Pengajuan Button
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToResume, // Navigate to ResumeScreen
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
