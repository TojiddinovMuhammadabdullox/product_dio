import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_dio/models/product.dart';
import 'package:product_dio/repositories/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  void fetchProducts() async {
    try {
      emit(ProductLoading());
      final products = await repository.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void addProduct(Product product) async {
    try {
      print('Adding product: ${product.toJson()}');
      await repository.createProduct(product);
      fetchProducts(); // Re-fetch products after adding
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void updateProduct(Product product) async {
    try {
      print('Updating product: ${product.toJson()}');
      await repository.updateProduct(product);
      fetchProducts(); // Re-fetch products after updating
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void deleteProduct(int id) async {
    try {
      await repository.deleteProduct(id);
      fetchProducts(); // Re-fetch products after deleting
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
