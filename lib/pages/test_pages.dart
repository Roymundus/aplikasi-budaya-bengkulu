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

      if (index == widget.questionModel.data.length - 1) {
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
      } else {
        index++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kuis Kebudayaan Bengkulu",
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // // Gambar latar belakang
          // Positioned.fill(
          //   child: Opacity(
          //     opacity: 1.0,
          //     child: Image.asset(
          //       'assets/background-kuis.png',
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1} / ${widget.questionModel.data.length.toString()}',
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                                Text(
                                  widget.username,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: CountDownProgressIndicator(
                              controller: _controller,
                              valueColor: Colors.red,
                              backgroundColor: Color.fromARGB(255, 5, 188, 30),
                              initialPosition: 0,
                              duration: 360,
                              timeFormatter: (seconds) {
                                Duration duration = Duration(seconds: seconds);
                                String twoDigits(int n) =>
                                    n.toString().padLeft(2, '0');
                                String minutes =
                                    twoDigits(duration.inMinutes.remainder(60));
                                String secs =
                                    twoDigits(duration.inSeconds.remainder(60));
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
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.questionModel.data[index].question,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Expanded(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigate("a");
                                  },
                                  child: OptionWidget(
                                    optionChar: "A",
                                    optionDetail: widget
                                        .questionModel.data[index].optionA,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigate("b");
                                  },
                                  child: OptionWidget(
                                    optionChar: "B",
                                    optionDetail: widget
                                        .questionModel.data[index].optionB,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigate("c");
                                  },
                                  child: OptionWidget(
                                    optionChar: "C",
                                    optionDetail: widget
                                        .questionModel.data[index].optionC,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigate("d");
                                  },
                                  child: OptionWidget(
                                    optionChar: "D",
                                    optionDetail: widget
                                        .questionModel.data[index].optionD,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                optionChar,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 18, 80, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  optionDetail,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 18, 80, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
