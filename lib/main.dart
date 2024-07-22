import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_dio/blocs/product_cubit.dart';
import 'package:product_dio/repositories/product_repository.dart';
import 'package:product_dio/views/product_scren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ProductCubit(ProductRepository()),
        child: ProductListPage(),
      ),
    );
  }
}
