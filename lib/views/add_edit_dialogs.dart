import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_dio/blocs/product_cubit.dart';
import 'package:product_dio/models/product.dart';

class AddEditProductDialog extends StatefulWidget {
  final Product? product;
  final bool isEdit;

  const AddEditProductDialog({Key? key, this.product, this.isEdit = false})
      : super(key: key);

  @override
  _AddEditProductDialogState createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late double price;
  late String description;
  late int categoryId;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.product != null) {
      title = widget.product!.title;
      price = widget.product!.price;
      description = widget.product!.description;
      categoryId = widget.product!.categoryId;
      imageUrl =
          widget.product!.images.isNotEmpty ? widget.product!.images[0] : '';
    } else {
      title = '';
      price = 0.0;
      description = '';
      categoryId = 1; // Default category ID
      imageUrl = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Edit Product' : 'Add Product'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  price = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                initialValue: categoryId.toString(),
                decoration: InputDecoration(labelText: 'Category ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  categoryId = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: imageUrl,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  imageUrl = value!;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final product = Product(
                id: widget.isEdit
                    ? widget.product!.id
                    : 0, // ID should be 0 for new products
                title: title,
                price: price,
                description: description,
                categoryId: categoryId,
                images: [imageUrl],
              );
              if (widget.isEdit) {
                context.read<ProductCubit>().updateProduct(product);
              } else {
                context.read<ProductCubit>().addProduct(product);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.isEdit ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
