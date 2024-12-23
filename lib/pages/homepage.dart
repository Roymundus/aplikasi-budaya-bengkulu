import 'package:budaya_bengkulu/pages/homekuis.dart';
import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ensiklopedia Budaya Bengkulu',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Gambar latar belakang
          Positioned.fill(
            child: Opacity(
              opacity: 1.0,
              child: Image.asset(
                'assets/backgroundHomePage.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                children: [
                  MenuCard(
                    title: 'Menu Kabupaten',
                    icon: Icons.map_outlined,
                    color: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KabupatenSelectionPage()));
                    },
                  ),
                  MenuCard(
                    title: 'Ikuti kuis',
                    icon: Icons.quiz,
                    color: Colors.white,
                    onTap: () {
                      // Arahkan ke halaman kuis
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeKuis()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: color.withOpacity(1.0), width: 2), // Border tambahan
        ),
        elevation: 8, // Penambahan bayangan (shadow)
        shadowColor: color.withOpacity(
            0.4), // Warna bayangan yang disesuaikan dengan warna ikon
        color: color.withOpacity(0.1),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers content vertically
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class KabupatenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kabupaten'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Halaman Pemilihan Kabupaten'),
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mengikuti Kuis'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Halaman Kuis'),
      ),
    );
  }
}
