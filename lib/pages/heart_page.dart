import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:peach_pulse/pages/home_page.dart';

class HeartRatePage extends StatefulWidget {
  @override
  State<HeartRatePage> createState() => _HeartRatePageState();
}

class _HeartRatePageState extends State<HeartRatePage>
    with SingleTickerProviderStateMixin {
  int heartRate = 98;
  Timer? _timer;
  final Random _random = Random();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      setState(() {
        heartRate = 60 + _random.nextInt(40); // 60 - 99 bpm
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  Widget buildCard(String label, String value) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Heart Rate',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ScaleTransition(
            scale: _pulseAnimation,
            child: Icon(Icons.favorite, size: 100, color: Colors.redAccent),
          ),
          SizedBox(height: 20),
          Text(
            '$heartRate bpm',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            'Ritmo cardíaco actual',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 30),

          // Simulación de gráfico de pulso (puede reemplazarse con animación mejor luego)
          Container(
            height: 50,
            width: double.infinity,
            child: CustomPaint(painter: PulsePainter()),
          ),

          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCard("Promedio", "72 bpm"),
              buildCard("Máximo", "94 bpm"),
              buildCard("Mínimo", "65 bpm"),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.pink[200],
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            const SizedBox(width: 40), // espacio para el FAB
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: Icon(Icons.person), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink[300],
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class PulsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.redAccent
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path = Path();
    for (double x = 0; x < size.width; x++) {
      double y =
          size.height / 2 +
          sin(x / 10) * 8 +
          sin(x / 3) * 2; // combinación de ondas
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
