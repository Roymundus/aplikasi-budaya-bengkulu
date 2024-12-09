import 'package:flutter/material.dart';

class HasilPage extends StatefulWidget {
  final int result;
  const HasilPage({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Kuis"),
        backgroundColor: Colors.green, // Sesuaikan warna sesuai keinginan
      ),
      body: Stack(
        children: [
          // Gambar latar belakang
          Positioned.fill(
            child: Opacity(
              opacity: 1.0, // Transparansi gambar latar belakang
              child: Image.asset(
                'assets/backgroundHomePage.png', // Pastikan gambar ada di folder assets
                fit: BoxFit.cover, // Agar gambar menutupi seluruh layar
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/best-seller.png',
                    width: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Selamat!! Jawaban Kamu Benar sebanyak " +
                        widget.result.toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black), // Ubah warna teks agar kontras
                  ),
                  const SizedBox(height: 20), // Ruang tambahan sebelum tombol
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text("Kembali ke Menu Utama"),
                    style: ElevatedButton.styleFrom(
                      // ignore: deprecated_member_use
                      primary: Color.fromARGB(255, 22, 119, 26), // Warna tombol
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
