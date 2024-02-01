import 'package:bear/consts/app_color.dart';
import 'package:bear/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:delayed_display/delayed_display.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Duration initialDelay = Duration(seconds: 1);
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 420,
            child: Stack(
              children: [
                Positioned(
                  top: 120,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: AvatarGlow(
                      startDelay: const Duration(milliseconds: 1),
                      glowColor:AppColor.secondaryColor,
                      glowShape: BoxShape.circle,
                      child: const SizedBox(),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 60,
                  child: DelayedDisplay(
                    delay: initialDelay,
                    child: Image.asset(
                      'assets/bear_pic.png',
                      width: 350,
                      height: 350,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20),
            child: DelayedDisplay(
              delay: Duration(seconds: initialDelay.inSeconds + 1),
              child: const Text(
                'Explore emotions with our interactive bear!',
                style: TextStyle(
                  color:AppColor.secondaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.50,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20),
            child: DelayedDisplay(
              delay: Duration(seconds: initialDelay.inSeconds + 3),
              child: const Text(
                "Join our friendly bear for a fun journey into emotions! Learn and play in a whole new, exciting way ",
                style: TextStyle(
                  color:AppColor.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
