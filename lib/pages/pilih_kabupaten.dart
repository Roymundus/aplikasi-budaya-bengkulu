import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'kategori_budaya.dart';

class KabupatenSelectionPage extends StatefulWidget {
  @override
  _KabupatenSelectionPageState createState() => _KabupatenSelectionPageState();
}

class _KabupatenSelectionPageState extends State<KabupatenSelectionPage> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> kabupatenList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKabupatenData(); // Ambil data dari Firebase
  }

  // Fungsi untuk mengambil data dari Firebase
  void fetchKabupatenData() async {
    try {
      final snapshot =
          await database.child("-OCW6dIqvmXRFCCware0/kabupaten").get();
      if (snapshot.exists) {
        // Mengambil data sebagai Map
        final data = snapshot.value as Map<dynamic, dynamic>;

        // Mengonversi Map ke List
        final List<dynamic> kabupatenListFromMap = data.values.toList();

        // Menyaring dan memproses data
        final tempList =
            kabupatenListFromMap.where((item) => item != null).map((item) {
          return {
            "name": item["name"],
            "logo": item["logo"],
          };
        }).toList();

        setState(() {
          kabupatenList = tempList;
          isLoading = false;
        });
      } else {
        print("No data available");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Kabupaten"),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : kabupatenList.isEmpty
              ? const Center(child: Text("Tidak ada data tersedia"))
              : Container(
                  color: Colors.white,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: kabupatenList.length,
                    itemBuilder: (context, index) {
                      return KabupatenGridItem(
                        kabupaten: KabupatenModel(
                          kabupatenList[index]["name"],
                          kabupatenList[index]["logo"],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

class KabupatenModel {
  final String name;
  final String logoUrl;

  KabupatenModel(this.name, this.logoUrl);
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
            builder: (context) => KategoriBudayaPage(kabupaten: kabupaten),
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
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              kabupaten.logoUrl,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 50);
              },
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
