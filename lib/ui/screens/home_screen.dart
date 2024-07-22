import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_81/blocs/product_bloc.dart';
import 'package:lesson_81/blocs/product_event.dart';
import '../../blocs/product_state.dart';

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
                mainAxisExtent: 210,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: Column(
                    children: [
                      Image.network(product.id, fit: BoxFit.cover),
                      Text(product.title),
                      Text(product.price.toString()),
                    ],
                  ),
                );
              },
            );
          }

          return Container(child:
            Text("123"),);
        },
      ),
    );
  }
}
