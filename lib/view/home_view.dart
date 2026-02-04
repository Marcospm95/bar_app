import 'package:flutter/material.dart';
import 'package:marcos_platas_bar/view/crear_pedido_view.dart';
import '../viewmodel/home_view_model.dart';
import '../model/pedido.dart';
/// Pantalla que muestra la lista de pedidos creados y permite añadir nuevos pedidos
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel homeVM;

  @override
  void initState() {
    super.initState();
    homeVM = HomeViewModel();
  }
/// Abre la pantalla de crear pedido y espera el pedido
  void abrirPedido() async {
    final Pedido? nuevo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CrearPedidoView()),
    );
/// Si el usuario no guarda el pedido sera null
    if (nuevo != null) {
      setState(() {
        homeVM.anadirPedido(nuevo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Pedidos")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            /// Lista de pedidos guardados
            Expanded(
              child: ListView(
                children: homeVM.pedidos.map((p) {
                  return ListTile(
                    title: Text("Mesa: ${p.mesa}", textAlign: TextAlign.center),
                    subtitle: Text(
                      "Productos: ${homeVM.totalProductos(p)}\n"
                      "Precio: ${homeVM.totalPrecio(p).toStringAsFixed(2)} €",
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: abrirPedido,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
              child: const Text("Nuevo Pedido"),
            ),
          ],
        ),
      ),
    );
  }
}
