import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer(); // Inisialisasi audio player

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budaya Bengkulu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Budaya Bengkulu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isPlaying = false; // Status musik apakah sedang diputar atau tidak

  @override
  void initState() {
    super.initState();
    _playMusic(); // Memulai musik saat aplikasi dibuka
  }

  // Method untuk memutar musik
  Future<void> _playMusic() async {
    await audioPlayer.play(AssetSource(
        'assets/background.mp3')); // Pastikan file sudah ditambahkan di pubspec.yaml
    setState(() {
      isPlaying = true;
    });
  }

  // Method untuk menjeda musik
  Future<void> _pauseMusic() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  // Method untuk menghentikan musik
  Future<void> _stopMusic() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            // Tombol Play/Pause
            ElevatedButton(
              onPressed: () {
                if (isPlaying) {
                  _pauseMusic(); // Jeda jika sedang bermain
                } else {
                  _playMusic(); // Mainkan jika dijeda
                }
              },
              child: Text(isPlaying ? 'Pause Music' : 'Play Music'),
            ),
            const SizedBox(height: 10),
            // Tombol Stop
            ElevatedButton(
              onPressed: _stopMusic,
              child: const Text('Stop Music'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
