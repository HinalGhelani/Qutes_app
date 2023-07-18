import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qoutes_app/utils/slide_quotes.dart';
import 'package:qoutes_app/view/screens/Quotes_page.dart';
import 'package:qoutes_app/view/screens/categoryPage.dart';
import 'package:qoutes_app/view/screens/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashScreen',
    theme: ThemeData(useMaterial3: true),
    routes: {
      '/': (context) => const HomePage(),
      'splashScreen': (context) => const SplashScreen(),
      'categoryPage': (context) => const CategoryPage(),
      'quotesPage': (context) => const QuotesPage(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacementNamed('/'),
    );
  }

  String randomQuotes = (SlideQuotes.randomQuotes.toList()..shuffle()).first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.primaries[Random().nextInt(
        Colors.primaries.length,
      )],
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('"${randomQuotes}"',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: "Satisfy",
                ),
              ),
              const SizedBox(height: 270),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Life Quotes",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "Satisfy",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
