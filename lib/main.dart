import 'package:flutter/material.dart';

void main() {
  runApp(const HealthIndicatorApp());
}

class HealthIndicatorApp extends StatelessWidget {
  const HealthIndicatorApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff6750a4),
      ),
      home: const HealthIndicatorExample(),
    );
  }
}

class HealthIndicatorExample extends StatefulWidget {
  const HealthIndicatorExample({Key? key});

  @override
  _HealthIndicatorExampleState createState() =>
      _HealthIndicatorExampleState();
}

class _HealthIndicatorExampleState extends State<HealthIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double health = 0;
  int level = 0;
  double healthLimit = 100; // Inicialmente, a capacidade máxima de vida é 100

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _incrementHealth() {
    setState(() {
      health += 20;
      if (health >= healthLimit) {
        level++;
        healthLimit += level * 10;
        health = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Capacidade Máxima de Vida: ${healthLimit.toInt()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: screenWidth / 2,
              height: screenWidth / 2, 
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    value: health / healthLimit,
                    semanticsLabel: 'Health Indicator',
                  ),
                  Text(
                    '${health.toInt()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Nivel: $level',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ElevatedButton(
                  onPressed: _incrementHealth,
                  child: Text('Aumentar vida (+20)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
