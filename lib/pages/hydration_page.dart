import 'package:flutter/material.dart';
import 'package:peach_pulse/pages/home_page.dart';

class HydrationPage extends StatefulWidget {
  const HydrationPage({Key? key}) : super(key: key);

  @override
  State<HydrationPage> createState() => _HydrationPageState();
}

class _HydrationPageState extends State<HydrationPage>
    with SingleTickerProviderStateMixin {
  int totalMl = 0;
  final int goal = 2000;
  List<int> entries = [250, 250, 250];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: totalMl / goal,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  void _addWater(int amount) {
    if (totalMl + amount > goal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have reached your goal of 2000 ml!'),
          backgroundColor: Colors.green,
        ),
      );
      return;
    }

    setState(() {
      totalMl += amount;
      entries.add(amount);
      _controller.reset();
      _animation = Tween<double>(
        begin: 0,
        end: totalMl / goal,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      _controller.forward();
    });
  }

  void _showAddWaterDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Water Intake'),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount in ml',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final int? value = int.tryParse(controller.text);
                  if (value != null && value > 0) {
                    _addWater(value);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  void _restartProgress() {
    setState(() {
      totalMl = 0;
      entries.clear();
      _controller.reset();
      _animation = Tween<double>(
        begin: 0,
        end: 0,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lastEntry = entries.isNotEmpty ? '${entries.last} ml' : 'N/A';
    final entryCount = '${entries.length} today';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 239, 255), // azul pastel
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: _restartProgress,
                  icon: const Icon(Icons.refresh, color: Colors.blue),
                  label: const Text(
                    'Restart',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Hydration',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Icon(Icons.opacity, size: 64, color: Colors.lightBlue),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Today you took ',
                style: const TextStyle(fontSize: 20, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$totalMl',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(text: ' ml of water'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder:
                      (context, child) => LinearProgressIndicator(
                        value: _animation.value.clamp(0, 1),
                        minHeight: 24,
                        backgroundColor: Colors.lightBlue[100],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color.fromARGB(255, 0, 198, 212),
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$totalMl ml',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _infoCard(
                            icon: Icons.local_drink,
                            label: 'Last entry',
                            value: lastEntry,
                          ),
                          _infoCard(
                            icon: Icons.history,
                            label: 'Entries',
                            value: entryCount,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.lightBlueAccent[100],
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
        onPressed: _showAddWaterDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: 150,
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.lightBlue, size: 32),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
