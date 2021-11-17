import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant.dart';
import 'info_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const InfoScreen();
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: Center(
          child: Column(
        children: [
          Lottie.asset(
            "assets/lottie/32585-fireworks-display.json",
            controller: controller,
            onLoaded: (composotion) {
              controller.forward();
            },
          ),
          const SizedBox(height: 50),
          const Text("Congratulations", style: kTitleTextstyle),
        ],
      )),
    );
  }
}
