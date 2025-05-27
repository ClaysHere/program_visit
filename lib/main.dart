import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:program_visit/features/service/api_service.dart';
import 'package:program_visit/routing/app_routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await ApiService.initTokens();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        primaryColor: Colors.white, // warna utama untuk AppBar dan elemen lain
        scaffoldBackgroundColor: Colors.white, // background halaman
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // warna teks/icon di AppBar
          elevation: 0, // kalau ingin AppBar rata
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          secondary: Colors.grey, // atau warna aksen lain
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black), // warna teks utama
        ),
      ),
    );
  }
}
