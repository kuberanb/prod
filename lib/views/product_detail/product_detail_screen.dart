import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/home/product_model.dart';
import '../../utils/colors.dart';
import '../../view_models/product_detail/product_detail_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ProductDetailViewModel>().fetchProductDetail(widget.product.id!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? ''),
      ),
      body: Consumer<ProductDetailViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: kWhiteColor),
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

          if (viewModel.error != null) {
            return Center(
              child: Text(
                'Error: ${viewModel.error}',
                style: const TextStyle(color: kWhiteColor),
              ),
            );
          }

          final product = viewModel.product;
          if (product == null) return const SizedBox();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.images?.isNotEmpty ?? false)
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      itemCount: product.images!.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          product.images![index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  product.title ?? '',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  product.description ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price?.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(' ${product.rating ?? 0}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Brand: ${product.brand ?? ''}'),
                Text('Category: ${product.category ?? ''}'),
                Text('Stock: ${product.stock ?? 0}'),
                if (product.discountPercentage != null)
                  Text('Discount: ${product.discountPercentage}%'),
              ],
            ),
          );
        },
      ),
    );
  }
}