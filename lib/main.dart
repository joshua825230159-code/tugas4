import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfileFormPage(),
    );
  }
}

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final TextEditingController _nameController = TextEditingController();
  String? _gender;
  bool _acceptTerms = false;

  // Map hobi
  Map<String, bool> hobbies = {
    "Olahraga": false,
    "Musik": false,
    "Membaca": false,
    "Bermain Game": false,
  };

  void _submitData() {
    String name = _nameController.text;
    String gender = _gender ?? "-";
    String selectedHobbies = hobbies.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .join(", ");
    String acceptTerms = _acceptTerms ? "Ya" : "Tidak";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Data Profil Anda"),
          content: Text(
            "Nama: $name\n"
                "Jenis Kelamin: $gender\n"
                "Hobi: $selectedHobbies\n"
                "Menyetujui Syarat: $acceptTerms",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Profil Sederhana"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Nama Lengkap
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Jenis Kelamin
            const Text("Jenis Kelamin:"),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text("Laki-laki"),
                    value: "Laki-laki",
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("Perempuan"),
                    value: "Perempuan",
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Hobi
            const Text("Hobi:"),
            Column(
              children: hobbies.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: hobbies[key],
                  onChanged: (bool? value) {
                    setState(() {
                      hobbies[key] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Switch syarat
            SwitchListTile(
              title: const Text("Saya menyetujui Syarat dan Ketentuan"),
              value: _acceptTerms,
              onChanged: (bool value) {
                setState(() {
                  _acceptTerms = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Submit button
            ElevatedButton(
              onPressed: _acceptTerms ? _submitData : null,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
