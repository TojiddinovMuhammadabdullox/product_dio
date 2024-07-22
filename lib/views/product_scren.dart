import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_dio/blocs/product_cubit.dart';
import 'package:product_dio/views/add_edit_dialogs.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<ProductCubit>(),
                              child: AddEditProductDialog(
                                product: product,
                                isEdit: true,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<ProductCubit>()
                              .deleteProduct(product.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No products available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<ProductCubit>(),
              child: AddEditProductDialog(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
