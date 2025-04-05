import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:get_it/get_it.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController _cartController = GetIt.I.get<CartController>();

  @override
  void initState() {
    super.initState();
    _cartController.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartController.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Column(
        children: [
          Expanded(
            child:
                _cartController.items.isEmpty
                    ? const Center(child: Text('Carrinho vazio'))
                    : ListView.builder(
                      itemCount: _cartController.items.length,
                      itemBuilder: (context, index) {
                        final item = _cartController.items[index];
                        return ListTile(
                          leading: Image.asset(
                            item['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item['name']),
                          subtitle: Text(
                            'R\$ ${item['price'].toStringAsFixed(2)} - Qtd: ${item['quantity']}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _cartController.removeItem(index);
                            },
                          ),
                        );
                      },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: R\$ ${_cartController.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed:
                  _cartController.items.isEmpty
                      ? null
                      : () {
                      },
              child: const Text('Finalizar Compra'),
            ),
          ),
        ],
      ),
    );
  }
}
