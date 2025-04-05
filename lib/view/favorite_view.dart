import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/favorite_controller.dart';
import 'package:get_it/get_it.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final FavoriteController _favoriteController =
      GetIt.I.get<FavoriteController>();

  @override
  void initState() {
    super.initState();
    _favoriteController.addListener(_onFavoriteChanged);
  }

  @override
  void dispose() {
    _favoriteController.removeListener(_onFavoriteChanged);
    super.dispose();
  }

  void _onFavoriteChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body:
          _favoriteController.favoriteItems.isEmpty
              ? const Center(child: Text('Nenhum item favoritado ainda'))
              : ListView.builder(
                itemCount: _favoriteController.favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = _favoriteController.favoriteItems[index];
                  return ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                    subtitle: Text('R\$ ${item['price'].toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.pink),
                      onPressed: () {
                        _favoriteController.toggleFavorite(item);
                      },
                    ),
                  );
                },
              ),
    );
  }
}
