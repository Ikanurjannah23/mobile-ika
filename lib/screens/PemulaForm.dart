import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'ResumeScreen.dart'; // Import halaman ResumeScreen

class PemulaForm extends StatefulWidget {
  const PemulaForm({Key? key}) : super(key: key);

  @override
  State<PemulaForm> createState() => _PemulaFormState();
}

class _PemulaFormState extends State<PemulaForm> {
  final _formKey = GlobalKey<FormState>();
  File? _imageKK;
  File? _imageIjazah;
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
        } else if (type == 'Ijazah') {
          _imageIjazah = File(pickedFile.path);
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
        title: const Text('Form Pemula'),
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
                  color: const Color.fromARGB(255, 250, 250, 250), // Warna latar belakang lebih lembut
                  borderRadius: BorderRadius.circular(16), // Border lebih besar
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
                      'Formulir Pengajuan KTP Pemula',
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
                      controller: _namaController,
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
                      onTap: () => _selectDate(context),
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
                      controller: _teleponController,
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
                onPressed: () => _selectImage(ImageSource.gallery, 'KK'),
                icon: const Icon(Icons.image),
                label: const Text('Pilih Foto KK'),
              ),
              const SizedBox(height: 8),
              _imageKK == null
                  ? const Text('No image selected for KK.')
                  : Image.file(_imageKK!),
              const SizedBox(height: 16),

              // Unggah Foto Ijazah
              OutlinedButton.icon(
                onPressed: () => _selectImage(ImageSource.gallery, 'Ijazah'),
                icon: const Icon(Icons.image),
                label: const Text('Pilih Foto Ijazah atau SKL'),
              ),
              const SizedBox(height: 8),
              _imageIjazah == null
                  ? const Text('No image selected for Ijazah/SKL.')
                  : Image.file(_imageIjazah!),
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
                            imageIjazah: _imageIjazah,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Kirim Pengajuan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
