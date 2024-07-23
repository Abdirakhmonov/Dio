import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_81/blocs/product_bloc.dart';
import 'package:lesson_81/blocs/product_event.dart';
import '../../blocs/product_state.dart';
import 'add_edit_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: context.read<ProductBloc>()..add(GetProductsEvent()),
        builder: (context, state) {
          if (state is InitialProductState || state is LoadingProductState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorProductState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is LoadedProductState) {
            final products = state.products;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                mainAxisExtent: 230,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                              "https://cyrekdigital.com/static/9f3272e9bab7adf862a262a7df95d478/bf621/Pricing-error-miniatura-en.png");
                        },
                      ),
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(product.price.toString()),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ManageProductScreen(
                                    isEdit: true,
                                    product: product,
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<ProductBloc>().add(
                                  DeleteProductEvent(
                                      id: product.id.toString()));
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }

          return Container(
            child: Text("123"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ManageProductScreen(isEdit: false);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
