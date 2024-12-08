import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetailLaguPage extends StatefulWidget {
  final KabupatenModel kabupaten;

  const DetailLaguPage({
    Key? key,
    required this.kabupaten,
  }) : super(key: key);

  @override
  _DetailLaguPageState createState() => _DetailLaguPageState();
}

class _DetailLaguPageState extends State<DetailLaguPage> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  String ketnama = "Memuat data...";
  String deskripsiLagu = "Memuat deskripsi...";

  @override
  void initState() {
    super.initState();
    fetchLaguDaerah();
  }

  void fetchLaguDaerah() async {
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
              "-OCW6dIqvmXRFCCware0/kabupaten/$kabupatenId/budaya/kesenian/lagu_daerah")
          .get();

      if (snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          ketnama = data["nama"] ?? "Nama tidak tersedia.";
          deskripsiLagu = data["deskripsi"] ?? "Deskripsi tidak tersedia.";
        });
      } else {
        setState(() {
          ketnama = "Data tidak ditemukan.";
          deskripsiLagu = "Data tidak ditemukan.";
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        ketnama = "Error: $e";
        deskripsiLagu = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lagu Daerah - ${widget.kabupaten.name}"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0, // Optional: Add elevation for card shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ketnama,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  deskripsiLagu,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
