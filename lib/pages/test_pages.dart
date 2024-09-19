// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:budaya_bengkulu/models/question_model.dart';
import 'package:budaya_bengkulu/pages/hasil_test.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final QuestionModel questionModel;
  final String username;
  const TestPage(
      {Key? key, required this.questionModel, required this.username})
      : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _controller = CountDownController();
  int index = 0;
  int result = 0;

  void navigate(String optionChar) {
    setState(() {
      if (optionChar == widget.questionModel.data[index].correctOption) {
        result++;
      }
      index++;

      if (index == widget.questionModel.data.length) {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => HasilPage(
                      result: result,
                    )))
            .then(
          (value) {
            setState(() {});
          },
        );
      }
      ;
    });
  }

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
                    '${index + 1} / ${widget.questionModel.data.length.toString()}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    widget.username,
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
              duration: 360,
              timeFormatter: (seconds) {
                Duration duration = Duration(seconds: seconds);
                String twoDigits(int n) => n.toString().padLeft(2, '0');
                String minutes = twoDigits(duration.inMinutes.remainder(60));
                String secs = twoDigits(duration.inSeconds.remainder(60));
                return "$minutes:$secs";
              },
              onComplete: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => HasilPage(
                              result: result,
                            )))
                    .then(
                  (value) {
                    setState(() {});
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.questionModel.data[index].question,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              navigate("a");
            },
            child: OptionWidget(
                optionChar: "A",
                optionDetail: widget.questionModel.data[index].optionA,
                color: Colors.red),
          ),
          GestureDetector(
            onTap: () {
              navigate("b");
            },
            child: OptionWidget(
                optionChar: "B",
                optionDetail: widget.questionModel.data[index].optionB,
                color: Colors.blue),
          ),
          GestureDetector(
            onTap: () {
              navigate("c");
            },
            child: OptionWidget(
                optionChar: "C",
                optionDetail: widget.questionModel.data[index].optionC,
                color: Colors.black),
          ),
          GestureDetector(
            onTap: () {
              navigate("d");
            },
            child: OptionWidget(
                optionChar: "D",
                optionDetail: widget.questionModel.data[index].optionD,
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
