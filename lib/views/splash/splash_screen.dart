import 'package:flutter/material.dart';
import 'package:prod/utils/colors.dart';
import 'package:prod/views/login/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> gotoScreen(BuildContext context) async {
    print('Splash Screen Open');
    await Future.delayed(const Duration(milliseconds: 1500));
    print('Home Screen Open');
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((context) => const LoginScreen()),
      ),
    );
  }

  @override
  void initState() {
    gotoScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SingleChildScrollView(
          child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.45 * screenHeight,
                ),
                Text(
                  'Prod',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 0.04 * screenHeight, 
                    letterSpacing: 0.02 * screenWidth,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.35 * screenHeight,
            ),
            const CircularProgressIndicator(
              strokeWidth: 2,
              color: kWhiteColor,
            )
          ],
        ),
      )),
    );
  }
}