import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:budaya_bengkulu/pages/pilih_kabupaten.dart';

class DetailBahasaPage extends StatefulWidget {
  final KabupatenModel kabupaten;

  const DetailBahasaPage({
    Key? key,
    required this.kabupaten,
  }) : super(key: key);

  @override
  _DetailBahasaPageState createState() => _DetailBahasaPageState();
}

class _DetailBahasaPageState extends State<DetailBahasaPage> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  String ketnama = "Memuat data...";
  String deskripsiBahasa = "Memuat deskripsi...";
  String contohPertanyaan = "Memuat data...";
  String contohJawaban = "Memuat data...";

  @override
  void initState() {
    super.initState();
    fetchBahasaDaerah();
  }

  void fetchBahasaDaerah() async {
    try {
      // Membuat map untuk menggantikan nama kabupaten dengan ID
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

      // Mendapatkan ID kabupaten berdasarkan nama
      String kabupatenId = kabupatenIdMap[widget.kabupaten.name] ??
          "default_id"; // ID default jika nama kabupaten tidak ditemukan

      // Mengambil data dari Firebase menggunakan ID kabupaten
      final snapshot = await database
          .child(
              "-OCW6dIqvmXRFCCware0/kabupaten/$kabupatenId/budaya/bahasa_daerah")
          .get();

      if (snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          ketnama = data["nama"] ?? "Nama tidak tersedia.";
          deskripsiBahasa = data["deskripsi"] ?? "Deskripsi tidak tersedia.";
          contohPertanyaan =
              data["contoh"]?["pertanyaan"] ?? "Tidak ada contoh pertanyaan.";
          contohJawaban =
              data["contoh"]?["jawaban"] ?? "Tidak ada contoh jawaban.";
        });
      } else {
        setState(() {
          ketnama = "Data tidak ditemukan.";
          deskripsiBahasa = "Data tidak ditemukan.";
          contohPertanyaan = "Data tidak ditemukan.";
          contohJawaban = "Data tidak ditemukan.";
        });
      }
    } catch (e) {
      setState(() {
        ketnama = "Terjadi kesalahan saat memuat data.";
        deskripsiBahasa = "Terjadi kesalahan saat memuat data.";
        contohPertanyaan = "Terjadi kesalahan.";
        contohJawaban = "Terjadi kesalahan.";
      });
      print("Error fetching bahasa daerah: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bahasa Daerah ${widget.kabupaten.name}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    ketnama,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black),
                const SizedBox(height: 16),
                const Text(
                  "Deskripsi Bahasa:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  deskripsiBahasa,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black),
                const SizedBox(height: 16),
                const Text(
                  "Contoh Penggunaan:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Pertanyaan: $contohPertanyaan",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Jawaban: $contohJawaban",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
