import 'dart:convert';

import 'package:budaya_bengkulu/models/question_model.dart';
import 'package:budaya_bengkulu/pages/test_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late QuestionModel questionsModel;
  TextEditingController usernameController = TextEditingController();

  final String url =
      "https://script.google.com/macros/s/AKfycbxMo7SLLOK_5vDGzWzdC3Vqwy-4cQMZELDzrlMXMqGTp55VVhy7Yv4JzwyxaospgMBbRg/exec";

  void getAllData(String username) async {
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
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Silahkan Mengikuti Kuis",
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                    hintText: "Silahkan masukan nama anda",
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getAllData(usernameController.text);
              },
              child: Text("Mulai Kuis"),
            )
          ]),
        ),
      ),
    );
  }
}
