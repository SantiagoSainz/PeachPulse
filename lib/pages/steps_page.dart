import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:peach_pulse/pages/home_page.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({super.key});

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  late Stream<StepCount> _stepCountStream;
  int _stepGoal = 6000;
  int _steps = 0;
  int? _initialSteps;

  @override
  void initState() {
    super.initState();
    _startStepTracking();
  }

  void _startStepTracking() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError((error) {
      debugPrint('Step Count Error: $error');
    });
  }

  void _onStepCount(StepCount event) {
    setState(() {
      if (_initialSteps == null) {
        _initialSteps = event.steps;
      }
      _steps = event.steps - _initialSteps!;
    });
  }

  void _changeGoal() async {
    final newGoal = await showDialog<int>(
      context: context,
      builder: (context) {
        int tempGoal = _stepGoal;
        return AlertDialog(
          title: const Text('Change Step Goal'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter new step goal'),
            onChanged: (value) {
              tempGoal = int.tryParse(value) ?? _stepGoal;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, _stepGoal),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, tempGoal),
              child: const Text('Set'),
            ),
          ],
        );
      },
    );

    if (newGoal != null && newGoal > 0) {
      setState(() {
        _stepGoal = newGoal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_steps / _stepGoal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE7),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.orangeAccent[100],
        notchMargin: 8.0,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _changeGoal,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    const Text(
                      'Steps',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Icon(Icons.directions_walk, size: 60, color: Colors.orange),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: LinearProgressIndicator(
                  value: (_steps / _stepGoal).clamp(0.0, 1.0),
                  minHeight: 4,
                  backgroundColor: Colors.orangeAccent,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "${(_steps * 60 / (DateTime.now().minute == 0 ? 1 : DateTime.now().minute)).toStringAsFixed(0)} Steps/hr",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "30:15:46",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Icon(
                            Icons.directions_run,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Total Kilocalo",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "656 Kcal",
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(thickness: 1, color: Colors.grey),
                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            "Next",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Icon(Icons.directions_bike, color: Colors.black),
                          SizedBox(height: 8),
                          Text("30 min"),
                          Text(
                            "Outdoor Cycle",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
