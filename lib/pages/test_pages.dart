// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1 / 5",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Alpian",
                    style: TextStyle(fontSize: 18),
                  )
                ]),
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: CountDownProgressIndicator(
              controller: _controller,
              valueColor: Colors.red,
              backgroundColor: Colors.blue,
              initialPosition: 0,
              duration: 365,
              timeFormatter: (seconds) {
                return Duration(seconds: seconds)
                    .toString()
                    .split('.')[0]
                    .padLeft(8, '0');
              },
              text: 'hh:mm:ss',
              onComplete: () => null,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Ibukota Negara Indonesia Adalah...",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {},
            child: OptionWidget(
                optionChar: "A",
                optionDetail: "Ibukota Nusantara (IKN)",
                color: Colors.red),
          ),
          GestureDetector(
            onTap: () {},
            child: OptionWidget(
                optionChar: "B", optionDetail: "Jakarta", color: Colors.blue),
          ),
          GestureDetector(
            onTap: () {},
            child: OptionWidget(
                optionChar: "C",
                optionDetail: "Jogjakarta",
                color: Colors.black),
          ),
          GestureDetector(
            onTap: () {},
            child: OptionWidget(
                optionChar: "D",
                optionDetail: "Bandung)",
                color: Colors.orange),
          ),
        ],
      ),
    ));
  }
}

class OptionWidget extends StatelessWidget {
  final String optionChar;
  final String optionDetail;
  final Color color;
  const OptionWidget({
    Key? key,
    required this.optionChar,
    required this.optionDetail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Text(
              optionChar,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                optionDetail,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ]),
        ),
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}
