import 'package:flutter/material.dart';
import '../viewmodel/crear_pedido_view_model.dart';
import '../model/producto.dart';

class ResumenPedidoView extends StatelessWidget {
  const ResumenPedidoView({super.key});

  @override
  Widget build(BuildContext context) {
    final CrearPedidoViewModel vm =
        ModalRoute.of(context)!.settings.arguments as CrearPedidoViewModel;

    return Scaffold(
      appBar: AppBar(title: const Text("Resumen")),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text("Mesa: ${vm.mesa}"),

            const SizedBox(height: 20),

            const Text("Productos:"),

            Expanded(
              child: ListView(
                children: vm.productos.entries.map((e) {
                  Producto p = e.key;
                  int cant = e.value;
                  return ListTile(
                    title: Text(p.nombre),
                    subtitle: Text("Cantidad: $cant"),
                    trailing: Text("${(p.precio * cant).toStringAsFixed(2)} €"),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            Text("Total: ${vm.precioTotal().toStringAsFixed(2)} €"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
