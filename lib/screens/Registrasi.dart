import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'AkunScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _gender;
  String? _selectedDate;
  final _formKey = GlobalKey<FormState>();

  // Fungsi untuk registrasi
  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        // Simpan data registrasi
        LoginScreen.registeredEmail = _emailController.text;
        LoginScreen.registeredPassword = _passwordController.text;

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
        );

        // Navigasi ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password dan konfirmasi tidak cocok')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
        backgroundColor: const Color.fromARGB(255, 155, 38, 11),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/register_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Daftar Akun',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 51, 22),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Input Form Fields
                      _buildTextField('NIK', 'Masukkan NIK', Icons.perm_identity, _nikController),
                      const SizedBox(height: 15),
                      _buildTextField('Nama Lengkap', 'Masukkan Nama Lengkap', Icons.person, _nameController),
                      const SizedBox(height: 15),
                      _buildTextField('Email', 'Masukkan Email', Icons.email, _emailController),
                      const SizedBox(height: 15),
                      _buildTextField('Sandi', 'Masukkan sandi', Icons.lock, _passwordController, obscureText: true),
                      const SizedBox(height: 15),
                      _buildTextField(
                          'Konfirmasi Sandi', 'Konfirmasi sandi Anda', Icons.lock_outline, _confirmPasswordController,
                          obscureText: true),
                      const SizedBox(height: 15),
                      _buildTextField('No Telepon', 'Masukkan No Telepon', Icons.phone, _phoneController,
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 15),
                      _buildDropdownField('Jenis Kelamin', _gender, [
                        const DropdownMenuItem(
                          value: 'Laki-laki',
                          child: Text('Laki-laki'),
                        ),
                        const DropdownMenuItem(
                          value: 'Perempuan',
                          child: Text('Perempuan'),
                        ),
                      ], (value) {
                        setState(() {
                          _gender = value;
                        });
                      }),
                      const SizedBox(height: 15),
                      _buildDateField(context),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 155, 38, 11),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk TextField dengan validasi
  Widget _buildTextField(String label, String hint, IconData icon, TextEditingController controller,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Widget untuk DropdownButton
  Widget _buildDropdownField(String label, String? value, List<DropdownMenuItem<String>> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.person, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: value,
      items: items,
      onChanged: (value) => onChanged(value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Pilih $label';
        }
        return null;
      },
    );
  }

  // Widget untuk memilih tanggal
  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(text: _selectedDate),
      decoration: InputDecoration(
        labelText: 'Tanggal Lahir',
        hintText: 'Pilih Tanggal Lahir',
        prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
          });
        }
      },
      validator: (value) {
        if (_selectedDate == null) {
          return 'Pilih Tanggal Lahir';
        }
        return null;
      },
    );
  }
}
