// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';

class DetailtariTradisionalPage extends StatefulWidget {
  final KabupatenModel kabupaten;

  const DetailtariTradisionalPage({
    Key? key,
    required this.kabupaten,
  }) : super(key: key);

  @override
  _DetailtariTradisionalPageState createState() =>
      _DetailtariTradisionalPageState();
}

class _DetailtariTradisionalPageState extends State<DetailtariTradisionalPage> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> tariList = [];

  @override
  void initState() {
    super.initState();
    fetchtariTradisional();
  }

  void fetchtariTradisional() async {
    try {
      final snapshot = await database
          .child(
              "-OCW6dIqvmXRFCCware0/kabupaten/1/budaya/kesenian/tarian_tradisional")
          .get();

      if (snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          tariList = data.entries.map((entry) {
            final tari = entry.value as Map<dynamic, dynamic>;
            return {
              "nama": tari["nama"] ?? "Nama tidak tersedia.",
              "deskripsi": tari["deskripsi"] ?? "Deskripsi tidak tersedia.",
              "gambar": tari["gambar"] ??
                  "assets/367ba491fe4460d44becee0e83083c2b.jpg",
            };
          }).toList();
        });
      } else {
        setState(() {
          tariList = [];
        });
      }
    } catch (e) {
      setState(() {
        tariList = [];
      });
    }
  }

  // Fungsi untuk menampilkan popup detail
  void _showDetailPopup(Map<String, dynamic> tari) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            tari["nama"],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Besar
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: InteractiveViewer(
                    child: Image.network(
                      tari["gambar"],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 200,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Deskripsi Lengkap
                Text(
                  tari["deskripsi"],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.pop(context);
              },
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
        title: Text("Tari Tradisional",
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: tariList.isNotEmpty
            ? ListView.builder(
                itemCount: tariList.length,
                itemBuilder: (context, index) {
                  final tari = tariList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () => _showDetailPopup(tari),
                        child: Row(
                          children: [
                            // Gambar kecil
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                tari["gambar"],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 120,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Nama dan Deskripsi
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Nama tari
                                  Text(
                                    tari["nama"],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  // Deskripsi tari
                                  Text(
                                    tari["deskripsi"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search_off,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Data tari tradisional tidak tersedia.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: fetchtariTradisional,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
