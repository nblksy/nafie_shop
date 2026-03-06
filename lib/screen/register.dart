import 'package:flutter/material.dart';
import 'package:nafie_shop/database/sqflite.dart';
import 'package:nafie_shop/models/user_model.dart';
import 'package:nafie_shop/screen/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isObscure1 = true;
  bool isObscure2 = true;

  String selectedRole = "user";

  InputDecoration modernInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF00458E)),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF00458E), width: 2),
      ),
    );
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await DBHelper.registerUser(
          UserModel(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            nama: namaController.text.trim(),
            noHP: noHpController.text.trim(),
            // role: selectedRole,
          ),
        );

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Pendaftaran Berhasil"),
            content: const Text(
              "Silakan login menggunakan akun yang baru dibuat.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Login()),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Pendaftaran Gagal")));
      }
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9bafd9), Color(0xFF103783)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00458E),
                      ),
                    ),
                    const SizedBox(height: 25),

                    TextFormField(
                      controller: namaController,
                      decoration: modernInput("Nama Lengkap", Icons.person),
                      validator: (value) =>
                          value!.isEmpty ? "Nama wajib diisi" : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: emailController,
                      decoration: modernInput("Email", Icons.email),
                      validator: (value) {
                        if (value!.isEmpty) return "Email wajib diisi";
                        if (!value.contains("@")) {
                          return "Email harus mengandung @";
                        }
                        if (selectedRole == "admin" &&
                            !value.endsWith("@admin.com")) {
                          return "Admin harus menggunakan email @admin.com";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: noHpController,
                      keyboardType: TextInputType.number,
                      decoration: modernInput("Nomor HP", Icons.phone),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Nomor HP hanya angka";
                          }
                          if (value.length < 9 || value.length > 15) {
                            return "Nomor HP min 9 & max 15 digit";
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: passwordController,
                      obscureText: isObscure1,
                      decoration: modernInput("Password", Icons.lock).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure1
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () =>
                              setState(() => isObscure1 = !isObscure1),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "Password wajib diisi";
                        if (value.length < 6) {
                          return "Password minimal 6 karakter";
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return "Harus mengandung angka";
                        }
                        if (!RegExp(
                          r'[!@#$%^&*(),.?":{}|<>]',
                        ).hasMatch(value)) {
                          return "Harus mengandung simbol";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: isObscure2,
                      decoration:
                          modernInput(
                            "Konfirmasi Password",
                            Icons.lock_outline,
                          ).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () =>
                                  setState(() => isObscure2 = !isObscure2),
                            ),
                          ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Konfirmasi password wajib diisi";
                        }
                        if (value != passwordController.text) {
                          return "Password tidak cocok";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pilih Role",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00458E),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text("User"),
                          selected: selectedRole == "user",
                          selectedColor: const Color(0xFF00458E),
                          labelStyle: TextStyle(
                            color: selectedRole == "user"
                                ? Colors.white
                                : Colors.black,
                          ),
                          onSelected: (_) {
                            setState(() => selectedRole = "user");
                          },
                        ),
                        const SizedBox(width: 20),
                        ChoiceChip(
                          label: const Text("Admin"),
                          selected: selectedRole == "admin",
                          selectedColor: const Color(0xFF000328),
                          labelStyle: TextStyle(
                            color: selectedRole == "admin"
                                ? Colors.white
                                : Colors.black,
                          ),
                          onSelected: (_) {
                            setState(() => selectedRole = "admin");
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00458E),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Daftar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
