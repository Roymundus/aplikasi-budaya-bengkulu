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
            Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
          },
        ),
        backgroundColor: Colors.green, // Sesuaikan warna sesuai keinginan
      ),
      body: Stack(
        children: [
          // Gambar latar belakang
          Positioned.fill(
            child: Opacity(
              opacity: 1.0, // Transparansi gambar latar belakang
              child: Image.asset(
                'assets/background-kuis.png', // Pastikan gambar ada di folder assets
                fit: BoxFit.cover, // Agar gambar menutupi seluruh layar
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${index + 1} / ${widget.questionModel.data.length.toString()}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          widget.username,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CountDownProgressIndicator(
                    controller: _controller,
                    valueColor: Colors.red,
                    backgroundColor: const Color.fromARGB(255, 2, 87, 5),
                    initialPosition: 0,
                    duration: 360,
                    timeFormatter: (seconds) {
                      Duration duration = Duration(seconds: seconds);
                      String twoDigits(int n) => n.toString().padLeft(2, '0');
                      String minutes =
                          twoDigits(duration.inMinutes.remainder(60));
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
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.questionModel.data[index].question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    navigate("a");
                  },
                  child: OptionWidget(
                    optionChar: "A",
                    optionDetail: widget.questionModel.data[index].optionA,
                    color: Color.fromARGB(255, 17, 147, 21),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigate("b");
                  },
                  child: OptionWidget(
                    optionChar: "B",
                    optionDetail: widget.questionModel.data[index].optionB,
                    color: Color.fromARGB(255, 2, 87, 5),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigate("c");
                  },
                  child: OptionWidget(
                    optionChar: "C",
                    optionDetail: widget.questionModel.data[index].optionC,
                    color: Color.fromARGB(255, 17, 147, 21),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigate("d");
                  },
                  child: OptionWidget(
                    optionChar: "D",
                    optionDetail: widget.questionModel.data[index].optionD,
                    color: Color.fromARGB(255, 2, 87, 5),
                  ),
                ),
              ],
            ),
          ),
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Text(
              optionChar,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                optionDetail,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
