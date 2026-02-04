import 'package:flutter/material.dart';
import '../viewmodel/crear_pedido_view_model.dart';
import 'productos_view.dart';

/// Pantalla de creacion de pedidos
/// 
/// Funciones:
/// - introducir la mesa
/// - seleccionar producto y cantidades
/// - ver el resumen del peido
/// - guardar el pedido
class CrearPedidoView extends StatefulWidget {
  const CrearPedidoView({super.key});

  @override
  State<CrearPedidoView> createState() => _CrearPedidoViewState();
}

class _CrearPedidoViewState extends State<CrearPedidoView> {
  final CrearPedidoViewModel vm = CrearPedidoViewModel();

  /// Abre la pantalla de productos y espera los productos elegidos
  void abrirProductos() async {
    var seleccionados = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductosView()),
    );

  /// si el usuario confirma se guardan los productos, si cancela es null
    if (seleccionados != null) {
      setState(() {
        vm.guardarProductos(seleccionados);
      });
    }
  }

  /// Abre la pantalla de resumen usando una ruta
  void abrirResumen() {
    Navigator.pushNamed(context, '/resumen', arguments: vm);
  }

 ///Guarda el pedido y vuelve a la pantalla anterior con el pedido creado
  void guardar() {
    if (!vm.controlErrores()) {
      return;
    }
  /// si el pedido no esta completo no se guarda 
    var pedidoCompleto = vm.crearPedido();
    Navigator.pop(context, pedidoCompleto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear pedido")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            /// TextField para introducir el numero de mesa
            TextField(
              decoration: const InputDecoration(
                labelText: "Mesa",
              ),
              onChanged: (valor) {
                vm.guardarMesa(valor);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: abrirProductos,
              child: const Text("Añadir productos"),
            ),
            const SizedBox(height: 20),
            
            ///Lista de productos seleccionados con sus cantidades
            Expanded(
              child: ListView(
                children: vm.productos.entries.map((entrada) {
                  return ListTile(
                    title: Text(entrada.key.nombre),
                    subtitle: Text("Cantidad: ${entrada.value}"),
                    trailing: Text(
                      "${(entrada.key.precio * entrada.value).toStringAsFixed(2)} €",
                    ),
                  );
                }).toList(),
              ),
            ),
            /// Precio del pedido
            Text(
              "Total: ${vm.precioTotal().toStringAsFixed(2)} €",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: abrirResumen,
                  child: const Text("Ver resumen"),
                ),
                ElevatedButton(
                  onPressed: guardar,
                  child: const Text("Guardar pedido"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
