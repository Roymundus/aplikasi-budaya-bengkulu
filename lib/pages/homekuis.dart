import 'dart:convert';
import 'package:budaya_bengkulu/models/question_model.dart';
import 'package:budaya_bengkulu/pages/test_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

class HomeKuis extends StatefulWidget {
  const HomeKuis({super.key});

  @override
  State<HomeKuis> createState() => _HomePageState();
}

class _HomePageState extends State<HomeKuis> {
  late QuestionModel questionsModel;
  TextEditingController usernameController = TextEditingController();
  bool isLoading = false;

  final String url =
      "https://script.google.com/macros/s/AKfycbxMo7SLLOK_5vDGzWzdC3Vqwy-4cQMZELDzrlMXMqGTp55VVhy7Yv4JzwyxaospgMBbRg/exec";

  void getAllData(String username) async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await myhttp.get(Uri.parse(url));

      questionsModel = QuestionModel.fromJson(json.decode(response.body));

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TestPage(
                questionModel: questionsModel,
                username: username,
              )));
    } catch (err) {
      print("Error : " + err.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk tombol kembali
          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text('Kuis Ensiklopedia Budaya Bengkulu'),
        ),
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
          SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Silahkan Mengikuti Kuis",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                            hintText: "Silahkan masukan nama anda",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ),
                    isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              getAllData(usernameController.text);
                            },
                            child: const Text("Mulai Kuis"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(
                                  255, 22, 119, 26), // Warna tombol
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
