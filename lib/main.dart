import 'package:flutter/material.dart';
import 'view/home_view.dart';
import 'view/resumen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar App',
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      routes: {'/resumen': (context) => const ResumenPedidoView()},
    );
  }
}
