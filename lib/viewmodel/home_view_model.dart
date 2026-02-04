import 'package:flutter/material.dart';
import '../model/pedido.dart';
import '../model/producto.dart';
/// ViewModel de la pantalla principal
/// 
/// Gestiona la lista de pedidos y calcula el total de los productos
class HomeViewModel extends ChangeNotifier {
  final List<Pedido> pedidos = [];

  HomeViewModel() {
    pedidos.add(
      Pedido("Mesa 1", {
        const Producto("Colacao", 2): 1,
        const Producto("Napolitana", 2.50): 1,
      }),
    );

    pedidos.add(
      Pedido("Mesa 2", {
        const Producto("Cafe", 1.50): 1,
        const Producto("Triangulo", 2): 1,
      }),
    );
  }

  /// Añade un pedido nuevo a la lista
  void anadirPedido(Pedido p) {
    pedidos.add(p);
    notifyListeners();
  }

  /// Calcula el total de productos en un pedido
  int totalProductos(Pedido p) {
    int total = 0;
    p.productos.forEach((prod, cant) => total += cant);
    return total;
  }

  /// Calcula el precio total de un pedido
  double totalPrecio(Pedido p) {
    double total = 0;
    p.productos.forEach((prod, cant) {
      total += prod.precio * cant;
    });
    return total;
  }
}
