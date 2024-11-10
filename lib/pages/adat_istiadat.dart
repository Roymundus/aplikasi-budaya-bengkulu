import 'package:flutter/material.dart';

class AdatIstiadatPage extends StatelessWidget {
  final List<AdatDetailModel> adatDetails = [
    AdatDetailModel(
      'Upacara Adat',
      'Upacara adat adalah salah satu bentuk tradisi yang dilakukan oleh masyarakat untuk memperingati peristiwa penting, seperti kelahiran, pernikahan, dan kematian.',
      'assets/upacara-adat.jpg',
    ),
    AdatDetailModel(
      'Tradisi',
      'Tradisi adalah kebiasaan yang dilakukan secara turun-temurun oleh masyarakat, seperti tradisi mandi safar di Bengkulu.',
      'assets/tradisi.jpg',
    ),
    AdatDetailModel(
      'Ritual',
      'Ritual adalah kegiatan keagamaan atau budaya yang dilakukan dengan tata cara khusus, seperti ritual Tabot di Bengkulu.',
      'assets/ritual.jpeg',
    ),
    AdatDetailModel(
      'Perayaan',
      'Perayaan adalah kegiatan yang dilakukan untuk merayakan suatu peristiwa penting dalam budaya, seperti perayaan Tabot di Bengkulu.',
      'assets/perayaan.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adat Istiadat"),
        backgroundColor: Colors.green, // Sesuaikan dengan tema aplikasi
      ),
      body: Container(
        color: Colors.green, // Latar belakang aplikasi menjadi hijau
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: adatDetails.length,
          itemBuilder: (context, index) {
            return AdatDetailItem(adatDetail: adatDetails[index]);
          },
        ),
      ),
    );
  }
}

class AdatDetailModel {
  final String title;
  final String description;
  final String imagePath;

  AdatDetailModel(this.title, this.description, this.imagePath);
}

class AdatDetailItem extends StatelessWidget {
  final AdatDetailModel adatDetail;

  const AdatDetailItem({Key? key, required this.adatDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika item diklik, bisa diarahkan ke halaman detail adat istiadat
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white, // Ubah warna latar belakang Card menjadi putih
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                adatDetail.imagePath,
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
                      adatDetail.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .black, // Ubah warna teks menjadi hitam agar kontras
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      adatDetail.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors
                            .black54, // Ubah warna teks deskripsi menjadi hitam sedikit transparan
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
