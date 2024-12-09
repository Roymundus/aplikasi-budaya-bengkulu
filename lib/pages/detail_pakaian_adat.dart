// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';

class DetailPakaianTradisionalPage extends StatefulWidget {
  final KabupatenModel kabupaten;

  const DetailPakaianTradisionalPage({
    Key? key,
    required this.kabupaten,
  }) : super(key: key);

  @override
  _DetailPakaianTradisionalPageState createState() =>
      _DetailPakaianTradisionalPageState();
}

class _DetailPakaianTradisionalPageState
    extends State<DetailPakaianTradisionalPage> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  Map<String, dynamic>? pakaianTradisional;

  @override
  void initState() {
    super.initState();
    fetchPakaianTradisional();
  }

  void fetchPakaianTradisional() async {
    try {
      Map<String, String> kabupatenIdMap = {
        "Bengkulu Selatan": "1",
        "Bengkulu Tengah": "2",
        "Kota Bengkulu": "3",
        "Lebong": "4",
        "Rejang Lebong": "5",
        "Seluma": "6",
        "Bengkulu Utara": "7",
        "Mukomuko": "8",
        "Kaur": "-OCWCcEeY0C4z88JFgtO",
        "Kepahiang": "-OCWFWFbCiO_AWb1cFW8",
      };

      String kabupatenId =
          kabupatenIdMap[widget.kabupaten.name] ?? "default_id";

      final snapshot = await database
          .child(
              "-OCW6dIqvmXRFCCware0/kabupaten/$kabupatenId/budaya/kesenian/pakaian_adat")
          .get();

      if (snapshot.value != null) {
        final data = snapshot.value;

        if (data is Map<dynamic, dynamic>) {
          final firstEntry = data.entries.first;
          final pakaian = firstEntry.value;

          if (pakaian is Map<dynamic, dynamic>) {
            setState(() {
              pakaianTradisional = {
                "nama": pakaian["nama"] ?? "Nama tidak tersedia.",
                "deskripsi":
                    pakaian["deskripsi"] ?? "Deskripsi tidak tersedia.",
                "gambar": pakaian["gambar"] ??
                    "assets/367ba491fe4460d44becee0e83083c2b.jpg",
              };
            });
          } else {
            setState(() {
              pakaianTradisional = null;
            });
          }
        } else {
          setState(() {
            pakaianTradisional = null;
          });
        }
      } else {
        setState(() {
          pakaianTradisional = null;
        });
      }
    } catch (e) {
      setState(() {
        pakaianTradisional = null;
      });
    }
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pakaian Tradisional (${widget.kabupaten.name})"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: pakaianTradisional != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar dengan Shadow dan Klik
                    GestureDetector(
                      onTap: () {
                        _showImageDialog(pakaianTradisional!["gambar"]);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Image.network(
                            pakaianTradisional!["gambar"],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 100,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Nama
                    Text(
                      pakaianTradisional!["nama"],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Garis Pemisah
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                    // Deskripsi
                    Text(
                      pakaianTradisional!["deskripsi"],
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
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
                      "Data pakaian tradisional tidak tersedia.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: fetchPakaianTradisional,
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
