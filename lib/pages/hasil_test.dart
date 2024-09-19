import 'package:flutter/material.dart';

class HasilPage extends StatefulWidget {
  final int result;
  const HasilPage({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Image.asset(
            'assets/best-seller.png',
            width: 150,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Selamat!! Jawaban Kamu Benar sebanyak " + widget.result.toString(),
            style: TextStyle(fontSize: 15),
          )
        ]))));
  }
}
