import 'package:marcos_platas_bar/model/producto.dart';

/// Modelo que representa un pedido del bar
class Pedido {
  final String mesa;
  final Map<Producto, int> productos;

  const Pedido(
    this.mesa,
    this.productos
  );

}