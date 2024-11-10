import 'package:flutter/material.dart';

class DetailBahasaPage extends StatelessWidget {
  const DetailBahasaPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bahasa Daerah"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green, // Ubah warna latar belakang menjadi hijau
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Bahasa Daerah",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Ubah warna teks menjadi putih agar kontras
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                    color: Colors.white), // Ubah warna divider menjadi putih
                const SizedBox(height: 16),
                const Text(
                  "Deskripsi Bahasa:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ubah warna teks menjadi putih
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Bahasa daerah adalah bahasa yang digunakan oleh masyarakat di suatu daerah tertentu. Bahasa daerah ini memiliki ciri khas tersendiri dan seringkali berbeda dengan bahasa Indonesia. Bahasa daerah juga merupakan bagian dari kekayaan budaya suatu daerah dan perlu dilestarikan agar tidak pun",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors
                        .white70, // Ubah warna teks menjadi putih dengan transparansi
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Divider(
                    color: Colors.white), // Ubah warna divider menjadi putih
                const SizedBox(height: 16),
                const Text(
                  "Contoh Penggunaan:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ubah warna teks menjadi putih
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "1. Selamat pagi: \"Selamat pagi\" dalam bahasa daerah ini diucapkan sebagai \"...\"",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors
                        .white70, // Ubah warna teks menjadi putih dengan transparansi
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "2. Terima kasih: \"Terima kasih\" dalam bahasa daerah ini diucapkan sebagai \"...\"",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors
                        .white70, // Ubah warna teks menjadi putih dengan transparansi
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
