import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsServices>(context);
    if (productService.isLoading) return const LoadingScreen();
    final products = productService.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              productService.selectedProduct = productService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
            child: ProductCard(product: products[index])),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
