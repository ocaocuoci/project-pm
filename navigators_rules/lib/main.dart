import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // PERBAIKAN: Menambahkan ColorScheme sebelum .fromSeed
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GantiWarnaPage(),
    );
  }
}

class GantiWarnaPage extends StatefulWidget {
  const GantiWarnaPage({super.key});

  @override
  State<GantiWarnaPage> createState() => _GantiWarnaPageState();
}

class _GantiWarnaPageState extends State<GantiWarnaPage> {
  bool _isBlue = true;

  void _ubahWarna() {
    setState(() {
      _isBlue = !_isBlue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isBlue ? Colors.blue[100] : Colors.pink[100],
      appBar: AppBar(
        title: const Text('Contoh Stateful: Ubah Warna'),
        backgroundColor: _isBlue ? Colors.blue : Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isBlue ? 'Warna Biru' : 'Warna Merah Muda',
              style: TextStyle(
                fontSize: 24,
                color: _isBlue ? Colors.blue[900] : Colors.pink[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ubahWarna,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isBlue ? Colors.blue : Colors.pink,
                foregroundColor: Colors.white, // Agar teks tombol putih
              ),
              child: const Text('Ubah Warna'),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleChildExample extends StatelessWidget {
  const SingleChildExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Single Child Layout Example'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Text(
            'Hello Flutter!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

//colum
class ColumnExample extends StatelessWidget {
  const ColumnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Contoh Column')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ini baris pertama'),
            Text('Ini baris kedua'),
            ElevatedButton(
              onPressed: () {},
              child: Text('Tombol'),
            ),
          ],
        ),
      ),
    );
  }
}

//stack
class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Contoh Stack')),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(width: 200, height: 200, color: Colors.blue[100]),
              Container(width: 150, height: 150, color: Colors.blue[300]),
              Text(
                'Tumpuk!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}