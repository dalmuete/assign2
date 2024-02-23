import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:assignment_2/models/product.dart';
import 'package:assignment_2/providers/productsprovider.dart';

// ignore: must_be_immutable
class ManageProductScreen extends StatefulWidget {
  ManageProductScreen({
    super.key,
    this.index,
  });

  int? index;

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  var codeController = TextEditingController();

  var nameController = TextEditingController();

  var priceController = TextEditingController();

  var quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<Products>(context);
    Product? product;

    if (widget.index != null) {
      product = productProvider.item(widget.index!);
    }
    codeController.text = product?.code ?? '';
    nameController.text = product?.nameDesc ?? '';
    priceController.text = product?.price.toString() ?? '';
    bool isProductFavorite = product?.isFavorite ?? false;
    bool isProductCart = product?.isCart ?? false;
    int quantitys = product?.quantity ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == null ? 'Add Product' : 'Edit Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            readOnly: widget.index != null,
            controller: codeController,
            decoration: const InputDecoration(
                label: Text('Code'), border: OutlineInputBorder()),
          ),
          const Gap(8),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                label: Text('Name/Desc'), border: OutlineInputBorder()),
          ),
          const Gap(8),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
                label: Text('Price'), border: OutlineInputBorder()),
          ),
          ElevatedButton(
            onPressed: () {
              if (codeController.text.isEmpty ||
                  nameController.text.isEmpty ||
                  priceController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Please enter values for all fields.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else if (!RegExp(r'^[0-9]+(?:\.[0-9]+)?$')
                  .hasMatch(priceController.text)) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content:
                          Text('Please input a number for the price.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else if (widget.index == null) {
                var p = Product(
                  code: codeController.text,
                  nameDesc: nameController.text,
                  price: double.parse(priceController.text),
                  isFavorite: isProductFavorite,
                  isCart: isProductCart,
                  quantity: quantitys,
                );
                productProvider.add(p);
                Navigator.of(context).pop();
              } else {
                var p = Product(
                  code: codeController.text,
                  nameDesc: nameController.text,
                  price: double.parse(priceController.text),
                  isFavorite: isProductFavorite,
                  isCart: isProductCart,
                  quantity: quantitys,
                );
                productProvider.updateitem(p, widget.index!);
                Navigator.of(context).pop();
              }
            },
            child: Text(widget.index == null ? 'ADD' : 'EDIT'),
          )
        ],
      ),
    );
  }
}
