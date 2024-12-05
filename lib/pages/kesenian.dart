import 'package:flutter/material.dart';

class DetailKesenianPage extends StatelessWidget {
  final List<KesenianDetailModel> kesenianDetails = [
    KesenianDetailModel(
      'Lagu Daerah',
      'Lagu daerah adalah lagu-lagu tradisional yang sangat identik dengan budaya dan identitas suatu daerah. Lagu ini biasa dimainkan pada acara-acara tertentu yang berhubungan dengan budaya dan adat.',
      'assets/music3.jpg',
    ),
    KesenianDetailModel(
      'Pakaian Adat',
      'Pakaian adat merupakan simbol budaya dan identitas dari suatu daerah. Setiap daerah memiliki pakaian adat yang berbeda-beda, yang biasanya dipakai dalam acara resmi atau upacara adat.',
      'assets/367ba491fe4460d44becee0e83083c2b.jpg',
    ),
    KesenianDetailModel(
      'Senjata Tradisional',
      'Senjata tradisional adalah alat yang digunakan oleh masyarakat adat untuk keperluan berburu, pertahanan, dan sebagai simbol kekuatan atau status sosial.',
      'assets/kerambit_169.jpeg',
    ),
    KesenianDetailModel(
      'Tarian Tradisional',
      'Tarian tradisional adalah tarian yang diwariskan turun-temurun dan menjadi bagian tak terpisahkan dari kebudayaan daerah. Setiap daerah memiliki tarian khas yang menggambarkan nilai-nilai budaya dan sejarah daerah tersebut.',
      'assets/608baa9936f63.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kesenian Daerah"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white, // Background color of the page
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: kesenianDetails.length,
          itemBuilder: (context, index) {
            return KesenianDetailItem(kesenianDetail: kesenianDetails[index]);
          },
        ),
      ),
    );
  }
}

class KesenianDetailModel {
  final String title;
  final String description;
  final String imagePath;

  KesenianDetailModel(this.title, this.description, this.imagePath);
}

class KesenianDetailItem extends StatelessWidget {
  final KesenianDetailModel kesenianDetail;

  const KesenianDetailItem({Key? key, required this.kesenianDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Action on tapping the item, you can navigate to a detailed page
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white, // Card background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                kesenianDetail.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kesenianDetail.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kesenianDetail.description,
                      style: const TextStyle(
                        fontSize: 14,
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
