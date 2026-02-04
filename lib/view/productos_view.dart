import 'package:flutter/material.dart';
import '../viewmodel/productos_view_model.dart';
import '../model/producto.dart';

class ProductosView extends StatefulWidget {
  const ProductosView({super.key});

  @override
  State<ProductosView> createState() => _ProductosViewState();
}

class _ProductosViewState extends State<ProductosView> {
  final ProductosViewModel vm = ProductosViewModel();
  final Map<Producto, int> productoElegido = {};

  void sumarProductos(Producto p) {
    setState(() {
      if (productoElegido.containsKey(p)) {
        productoElegido[p] = productoElegido[p]! + 1;
      } else {
        productoElegido[p] = 1;
      }
    });
  }

  void restarProductos(Producto p) {
    if (!productoElegido.containsKey(p)) return;
    setState(() {
      int cant = productoElegido[p]!;
      if (cant > 1) {
        productoElegido[p] = cant - 1;
      } else {
        productoElegido.remove(p);
      }
    });
  }

  void confirmar() {
    Navigator.pop(context, productoElegido);
  }

  void cancelar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar productos")),

      body: ListView(
        children: [
          for (var p in vm.productos)
            ListTile(
              title: Text(p.nombre),
              subtitle: Text(
                "Precio: ${p.precio.toStringAsFixed(2)} €"
                "\nCantidad: ${productoElegido[p] ?? 0}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      restarProductos(p);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: () {
                      sumarProductos(p);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: cancelar, child: const Text("Cancelar")),
            ElevatedButton(
              onPressed: confirmar,
              child: const Text("Confirmar"),
            ),
          ],
        ),
      ),
    );
  }
}
