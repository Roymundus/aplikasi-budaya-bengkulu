import 'package:budaya_bengkulu/pages/detail_lagu_daerah.dart';
import 'package:budaya_bengkulu/pages/detail_pakaian_adat.dart';
import 'package:budaya_bengkulu/pages/detail_senjata.dart';
import 'package:budaya_bengkulu/pages/detail_tari_tradisional.dart';
import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';
import 'package:flutter/material.dart';

class DetailKesenianPage extends StatelessWidget {
  final KabupatenModel kabupaten;

  DetailKesenianPage({Key? key, required this.kabupaten}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kesenian (${kabupaten.name})",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(6.0),
                children: [
                  _buildKategoriCard(
                    context,
                    title: "Lagu Daerah",
                    description:
                        "Lagu daerah adalah lagu-lagu tradisional yang sangat identik dengan budaya dan identitas suatu daerah. Lagu ini biasa dimainkan pada acara-acara tertentu yang berhubungan dengan budaya dan adat.",
                    imagePath: 'assets/music3.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailLaguPage(
                            kabupaten: kabupaten,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  _buildKategoriCard(
                    context,
                    title: "Pakaian Adat",
                    description:
                        "Pakaian adat merupakan simbol budaya dan identitas dari suatu daerah. Setiap daerah memiliki pakaian adat yang berbeda-beda, yang biasanya dipakai dalam acara resmi atau upacara adat.",
                    imagePath: 'assets/367ba491fe4460d44becee0e83083c2b.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPakaianTradisionalPage(
                            kabupaten: kabupaten,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  _buildKategoriCard(
                    context,
                    title: "Senjata Tradisional",
                    description:
                        "Senjata tradisional adalah alat yang digunakan oleh masyarakat adat untuk keperluan berburu, pertahanan, dan sebagai simbol kekuatan atau status sosial.",
                    imagePath: 'assets/kerambit_169.jpeg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsenjataTradisionalPage(
                            kabupaten: kabupaten,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  _buildKategoriCard(
                    context,
                    title: "Tarian Tradisional",
                    description:
                        "Tarian tradisional adalah tarian yang diwariskan turun-temurun dan menjadi bagian tak terpisahkan dari kebudayaan daerah. Setiap daerah memiliki tarian khas yang menggambarkan nilai-nilai budaya dan sejarah daerah tersebut.",
                    imagePath: 'assets/608baa9936f63.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailtariTradisionalPage(
                            kabupaten: kabupaten,
                          ),
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
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
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
      ),
    );
  }
}
