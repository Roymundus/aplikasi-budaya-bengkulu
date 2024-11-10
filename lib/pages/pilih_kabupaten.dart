import 'package:budaya_bengkulu/pages/kategori_budaya.dart';
import 'package:flutter/material.dart';

class KabupatenSelectionPage extends StatelessWidget {
  final List<KabupatenModel> kabupatenList = [
    KabupatenModel('Kabupaten Bengkulu Selatan',
        'assets/logo-kabupaten/Bengkulu_Selatan.png'),
    KabupatenModel('Kabupaten Bengkulu Tengah',
        'assets/logo-kabupaten/Lambang_Kabupaten_Bengkulu_Tengah.png'),
    KabupatenModel('Kabupaten Bengkulu Utara',
        'assets/logo-kabupaten/Logo_Bengkulu_Utara.png'),
    KabupatenModel(
        'Kabupaten Kaur', 'assets/logo-kabupaten/50px-Kabupaten_Kaur.png'),
    KabupatenModel(
        'Kabupaten Kepahiang', 'assets/logo-kabupaten/kepahiang.png'),
    KabupatenModel('Kabupaten Lebong', 'assets/logo-kabupaten/50px-Lebong.png'),
    KabupatenModel(
        'Kabupaten Mukomuko', 'assets/logo-kabupaten/Logo_Mukomuko.png'),
    KabupatenModel('Kabupaten Rejang Lebong',
        'assets/logo-kabupaten/50px-Rejang_Lebong.png'),
    KabupatenModel('Kabupaten Seluma', 'assets/logo-kabupaten/50px-Seluma.png'),
    KabupatenModel(
        'Kota Bengkulu', 'assets/logo-kabupaten/50px-Kota_Bengkulu.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Kabupaten"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green,
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1,
          ),
          itemCount: kabupatenList.length,
          itemBuilder: (context, index) {
            return KabupatenGridItem(kabupaten: kabupatenList[index]);
          },
        ),
      ),
    );
  }
}

class KabupatenModel {
  final String name;
  final String logoPath;

  KabupatenModel(this.name, this.logoPath);
}

class KabupatenGridItem extends StatelessWidget {
  final KabupatenModel kabupaten;

  const KabupatenGridItem({Key? key, required this.kabupaten})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KategoriBudayaPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kabupaten.logoPath,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              kabupaten.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
