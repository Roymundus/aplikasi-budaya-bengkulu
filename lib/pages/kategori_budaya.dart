import 'package:budaya_bengkulu/pages/adat_istiadat.dart';
import 'package:budaya_bengkulu/pages/bahasa_daerah.dart';
import 'package:budaya_bengkulu/pages/kesenian.dart';
import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';
import 'package:flutter/material.dart';

class KategoriBudayaPage extends StatelessWidget {
  final KabupatenModel kabupaten;

  const KategoriBudayaPage({Key? key, required this.kabupaten})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori Budaya (${kabupaten.name})"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildKategoriCard(
                    context,
                    title: "Bahasa Daerah",
                    description:
                        "Pelajari lebih dalam tentang Bahasa Daerah di ${kabupaten.name}.",
                    imagePath: 'assets/aksara-kaganga.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBahasaPage(
                            kabupaten: kabupaten,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildKategoriCard(
                    context,
                    title: "Kesenian",
                    description:
                        "Jelajahi berbagai kesenian tradisional dari ${kabupaten.name}.",
                    imagePath: 'assets/kesenian.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailKesenianPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildKategoriCard(
                    context,
                    title: "Adat Istiadat",
                    description:
                        "Pahami adat istiadat dan tradisi masyarakat ${kabupaten.name}.",
                    imagePath: 'assets/adat_istiadat.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdatIstiadatPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKategoriCard(BuildContext context,
      {required String title,
      required String description,
      required String imagePath,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Colors.green, // Warna hijau untuk stroke
            width: 2, // Ketebalan stroke
          ),
        ),
        elevation: 5,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
