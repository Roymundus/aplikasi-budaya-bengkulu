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
  List<Map<String, dynamic>> laguList = [];

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
          laguList = data.entries.map((entry) {
            final lagu = entry.value as Map<dynamic, dynamic>;
            return {
              "nama": lagu["nama"] ?? "Nama tidak tersedia.",
              "deskripsi": lagu["deskripsi"] ?? "Deskripsi tidak tersedia."
            };
          }).toList();
        });
      } else {
        setState(() {
          laguList = [];
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        laguList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lagu Daerah - ${widget.kabupaten.name}",
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/header-lagu-daerah.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.1), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Text(
                  widget.kabupaten.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // List lagu daerah
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: laguList.isNotEmpty
                    ? ListView.builder(
                        itemCount: laguList.length,
                        itemBuilder: (context, index) {
                          final lagu = laguList[index];
                          return Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.only(bottom: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                color: Colors.green, // warna hijau untuk stroke
                                width: 2.0, // ketebalan stroke
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.music_note,
                                color: Colors.green,
                                size: 36.0,
                              ),
                              title: Text(
                                lagu["nama"] ?? "Nama tidak tersedia",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                lagu["deskripsi"] ?? "Deskripsi tidak tersedia",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 64.0,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              "Tidak ada data lagu daerah.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
