import 'package:flutter/material.dart';
import '../model/pedido.dart';
import '../model/producto.dart';

class CrearPedidoViewModel extends ChangeNotifier {
  String mesa = "";
  Map<Producto, int> productos = {};

  void guardarMesa(String valor) {
    mesa = valor;
    notifyListeners();
  }

  void guardarProductos(Map<Producto, int> seleccionados) {
    productos = seleccionados;
    notifyListeners();
  }

  int totalProductos() {
    int total = 0;
    productos.forEach((p, cantidad) {
      total = total + cantidad;
    });
    return total;
  }

  double precioTotal() {
    double total = 0;
    productos.forEach((p, cantidad) {
      total += p.precio * cantidad;
    });
    return total;
  }

  bool controlErrores() {
    return mesa.isNotEmpty && productos.isNotEmpty;
  }

  Pedido crearPedido() {
    return Pedido(mesa, productos);
  }
}
