import 'package:flutter/material.dart';
import 'package:prod/view_models/home/home_view_model.dart';
import 'package:prod/view_models/login/login_view_model.dart';
import 'package:provider/provider.dart';
import 'views/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prod',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: Colors.black,
            background: Colors.black,
            surface: Colors.black,
            onPrimary: Colors.white,
            onBackground: Colors.white,
            onSurface: Colors.white,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
