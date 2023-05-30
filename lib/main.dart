import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:light_shop/firebase_options.dart';
import 'package:light_shop/screens/navigationRailScreen.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Light Shop",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: false,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.play(),
          bodyMedium: GoogleFonts.play(),
        ),
      ),
      home: const Scaffold(
        body: MyNavigationRailScreen(),
      ),
    );
  }
}
