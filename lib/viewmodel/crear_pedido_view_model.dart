import 'package:flutter/material.dart';
import '../model/pedido.dart';
import '../model/producto.dart';
/// ViewModel que se encarga de gestionar el estado del pedido se está creando
/// 
/// Funciones:
/// - Guarda la mesa
/// - Guarda los productos seleccionados con cantidades
/// - Calcula los totales y crea el objeto pedido
class CrearPedidoViewModel extends ChangeNotifier {
  String mesa = "";
  Map<Producto, int> productos = {};

  /// Guarda el valor de la mesa
  void guardarMesa(String valor) {
    mesa = valor;
    notifyListeners();
  }

  /// Guarda los productos seleccionados en la pantalla productos
  void guardarProductos(Map<Producto, int> seleccionados) {
    productos = seleccionados;
    notifyListeners();
  }

  /// Devuelve las unidades totales de los productos seleccionados
  int totalProductos() {
    int total = 0;
    productos.forEach((p, cantidad) {
      total = total + cantidad;
    });
    return total;
  }

  /// Calcula el precio total del pedido
  double precioTotal() {
    double total = 0;
    productos.forEach((p, cantidad) {
      total += p.precio * cantidad;
    });
    return total;
  }

  /// Comprueba que la mesa no este vacia y que hay almenos un producto
  bool controlErrores() {
    return mesa.isNotEmpty && productos.isNotEmpty;
  }

  /// Crea el objeto pedido
  Pedido crearPedido() {
    return Pedido(mesa, productos);
  }
}
