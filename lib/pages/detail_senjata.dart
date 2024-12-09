// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';

class DetailsenjataTradisionalPage extends StatefulWidget {
  final KabupatenModel kabupaten;

  const DetailsenjataTradisionalPage({
    Key? key,
    required this.kabupaten,
  }) : super(key: key);

  @override
  _DetailsenjataTradisionalPageState createState() =>
      _DetailsenjataTradisionalPageState();
}

class _DetailsenjataTradisionalPageState
    extends State<DetailsenjataTradisionalPage> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> senjataList = [];

  @override
  void initState() {
    super.initState();
    fetchsenjataTradisional();
  }

  void fetchsenjataTradisional() async {
    try {
      final snapshot = await database
          .child(
              "-OCW6dIqvmXRFCCware0/kabupaten/1/budaya/kesenian/senjata_tradisional")
          .get();

      if (snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          senjataList = data.entries.map((entry) {
            final senjata = entry.value as Map<dynamic, dynamic>;
            return {
              "nama": senjata["nama"] ?? "Nama tidak tersedia.",
              "deskripsi": senjata["deskripsi"] ?? "Deskripsi tidak tersedia.",
              "gambar": senjata["gambar"] ??
                  "assets/367ba491fe4460d44becee0e83083c2b.jpg",
            };
          }).toList();
        });
      } else {
        setState(() {
          senjataList = [];
        });
      }
    } catch (e) {
      setState(() {
        senjataList = [];
      });
    }
  }

  // Fungsi untuk menampilkan popup detail
  void _showDetailPopup(Map<String, dynamic> senjata) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            senjata["nama"],
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
                      senjata["gambar"],
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
                  senjata["deskripsi"],
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
        title: Text("Senjata Tradisional"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: senjataList.isNotEmpty
            ? ListView.builder(
                itemCount: senjataList.length,
                itemBuilder: (context, index) {
                  final senjata = senjataList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () => _showDetailPopup(senjata),
                        child: Row(
                          children: [
                            // Gambar kecil
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                senjata["gambar"],
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
                                  // Nama Senjata
                                  Text(
                                    senjata["nama"],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  // Deskripsi Senjata
                                  Text(
                                    senjata["deskripsi"],
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
                      "Data senjata tradisional tidak tersedia.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: fetchsenjataTradisional,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
