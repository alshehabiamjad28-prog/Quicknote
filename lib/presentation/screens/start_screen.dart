import 'package:flutter/material.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../main.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInQuint));

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => getStorage.read('started') == true
              ? HomeScreen()
              : OnboardingScreen(
                  onFinish: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
                      ),
                    );
                  },
                ),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(milliseconds: 900),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: w,
        height: h,
        color: Colors.white,
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: w * 0.60,
                  height: w * 0.60,
                  decoration: BoxDecoration(
                    color: Colors.black,

                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white60,
                        offset: Offset(1, 10),
                        blurRadius: 3.3,
                        spreadRadius: 1.1,
                        blurStyle: BlurStyle.solid,
                      ),
                    ],
                  ),
                  child: SizedBox(child: Image.asset('assets/icons/app_icon.jpeg',fit:BoxFit.cover ,),)
                ),
                SizedBox(height: h * 0.005),
                Text(
                  GlobalLoc.instance.appTitle,
                  style: TextStyle(
                    fontSize: w * 0.06,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,

                    letterSpacing: 1.4,

                    shadows: [
                      Shadow(
                        color: Colors.black12,
                        offset: Offset(1, 6),
                        blurRadius: 1.1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
