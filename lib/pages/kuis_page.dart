import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                decoration: const InputDecoration(
                    hintText: "Silahkan masukan nama anda",
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Mulai Kuis"),
            )
          ]),
        ),
      ),
    );
  }
}
