import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:peach_pulse/pages/heart_page.dart';
import 'package:peach_pulse/pages/hydration_page.dart';
import 'package:peach_pulse/pages/steps_page.dart';
import 'package:peach_pulse/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Color getMetricColor(String metric) {
    switch (metric) {
      case 'hydration':
        return Colors.lightBlue.shade100;
      case 'heart':
        return Colors.pink.shade100;
      case 'steps':
        return Colors.yellow.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  IconData getMetricIcon(String metric) {
    switch (metric) {
      case 'hydration':
        return LucideIcons.droplet;
      case 'heart':
        return LucideIcons.heart;
      case 'steps':
        return LucideIcons.clock;
      default:
        return LucideIcons.helpCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xFFFFCFE0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            SizedBox(width: 40), // espacio para el FAB
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink.shade200,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/ChatGPT Image.png',
                        ),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Peach',
                              style: TextStyle(color: Colors.pink),
                            ),
                            TextSpan(
                              text: 'Pulse',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/Ariana Grande.jpg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Expanded(child: Icon(Icons.donut_large, size: 60)),
                    Text(
                      'YOU ARE\nDOING\nAMAZING',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Metrics',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildMetricCard(context, 'hydration', '750 ml'),
                    _buildMetricCard(context, 'heart', '85 bpm'),
                    _buildMetricCard(context, 'steps', '2000 pies'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, String metric, String value) {
    return GestureDetector(
      onTap: () => navigateToMetricPage(context, metric),
      child: Container(
        decoration: BoxDecoration(
          color: getMetricColor(metric),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(getMetricIcon(metric), size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToMetricPage(BuildContext context, String metric) {
  if (metric == 'heart') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HeartRatePage()),
    );
  }
  if (metric == 'hydration') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HydrationPage()),
    );
  }
  if (metric == 'steps') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StepsPage()),
    );
  }
}
