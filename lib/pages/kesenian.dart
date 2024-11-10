import 'package:flutter/material.dart';

class DetailKesenianPage extends StatelessWidget {
  const DetailKesenianPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kesenian: "),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Gambar latar belakang dengan transparansi
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Transparansi gambar latar belakang
              child:
                  Image.asset('assets/background-kuis.png', fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Container(
              color: Colors.green, // Latar belakang hijau
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        "Kesenian Daerah ",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Lagu Daerah"),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Pakaian Adat"),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Senjata Tradisional"),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Tarian Tradisional"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat judul bagian
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Fungsi untuk membuat deskripsi teks
  Widget _buildDescriptionText(String description) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
