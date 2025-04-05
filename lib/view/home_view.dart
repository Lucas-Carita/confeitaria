import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/controller/favorite_controller.dart';
import 'package:get_it/get_it.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _cartController = GetIt.I.get<CartController>();
  final _favoriteController = GetIt.I.get<FavoriteController>();

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Bolo de Chocolate',
      'price': 45.90,
      'image': 'assets/bolo_chocolate.jpg',
    },
    {
      'name': 'Cupcake de Morango',
      'price': 12.50,
      'image': 'assets/cupcake_morango.jpg',
    },
    {'name': 'Donut', 'price': 8.75, 'image': 'assets/donut.jpg'},
    {
      'name': 'Torta de Limão',
      'price': 32.00,
      'image': 'assets/torta_limao.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _favoriteController.addListener(_updateFavorites);
  }

  @override
  void dispose() {
    _favoriteController.removeListener(_updateFavorites);
    super.dispose();
  }

  void _updateFavorites() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confeitaria'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () => Navigator.pushNamed(context, '/favorite'),
              ),
              if (_favoriteController.favoriteItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _favoriteController.favoriteItems.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            product['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'R\$ ${product['price'].toStringAsFixed(2)}',
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _cartController.addItem(
                                    product['name'],
                                    product['price'],
                                    product['image'],
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product['name']} adicionado ao carrinho',
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: const Text('Adicionar'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            _favoriteController.isFavorite(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                _favoriteController.isFavorite(product)
                                    ? Colors.pink
                                    : Colors.grey,
                          ),
                          onPressed: () {
                            _favoriteController.toggleFavorite(product);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: FloatingActionButton(
              mini: true,
              heroTag: 'aboutButton',
              onPressed: () => Navigator.pushNamed(context, '/about'),
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }
}
