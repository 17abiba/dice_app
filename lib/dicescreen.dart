import 'dart:math';
import 'package:flutter/material.dart';

Color customColor1 = const Color(0XFFFF494B);

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> with SingleTickerProviderStateMixin {
  final Random random = Random();
  List<int> diceValues = []; 
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1), 
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void rollDice(int numOfDice) {
    setState(() {
      diceValues = List.generate(numOfDice, (_) => 1);
    });

    controller.forward(from: 0).then((_) {
      setState(() {
        diceValues = List.generate(numOfDice, (_) => random.nextInt(6) + 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dice Rolling", style: TextStyle(color: customColor1, fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: diceValues.map((value){
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: animation.value * 6 * pi, 
                        child: Image.asset(
                          'assets/dice_$value.png',
                          width: 100,
                          height: 100,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => rollDice(1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor1,
                ),
                child: const Text(
                  "1 Dice",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => rollDice(2),
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor1,
                ),
                child: const Text(
                  "2 Dice",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => rollDice(3),
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor1,
                ),
                child: const Text(
                  "3 Dice",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
