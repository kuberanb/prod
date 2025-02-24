import 'package:flutter/material.dart';
import 'package:prod/models/home/product_model.dart';
import 'package:prod/utils/colors.dart';
import 'package:prod/view_models/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? userDetails;

  const HomeScreen({
    super.key,
    required this.userDetails,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when screen loads
    Future.microtask(
      () => context.read<HomeViewModel>().fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.userDetails?['firstName'] ?? ''}'),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kWhiteColor,
              ),
            );
          }

          if (viewModel.error != null) {
            return Center(
              child: Text(
                'Error: ${viewModel.error}',
                style: const TextStyle(
                  color: kWhiteColor,
                ),
              ),
            );
          }

          if (!viewModel.hasInternet) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.signal_wifi_off, size: 50),
                  SizedBox(height: 16),
                  Text('No internet connection'),
                ],
              ),
            );
          }

          return viewModel.products.isEmpty
              ? const Center(
                  child: Text(
                    "Products List empty",
                    style: TextStyle(
                      color: kWhiteColor,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewModel.products.length,
                  itemBuilder: (context, index) {
                    final product = viewModel.products[index];
                    return ProductCard(product: product);
                  },
                );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: Image.network(
              product.thumbnail ?? "",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  product.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price?.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(product.rating.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
