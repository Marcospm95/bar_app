import 'package:flutter/material.dart';
import 'package:marcos_platas_bar/model/producto.dart';
/// ViewModel que contiene la lista de productos 
class ProductosViewModel extends ChangeNotifier {
  final List<Producto> productos = [
    Producto("Colacao", 2),
    Producto("Napolitana", 2.50),
    Producto("Cafe", 1.50),
    Producto("Triangulo", 2),
    Producto("Agua", 1.20),
    Producto("Cerveza", 1.80),
    Producto("Tinto", 2.50),
  ];
}
