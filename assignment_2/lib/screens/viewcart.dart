import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assignment_2/providers/productsprovider.dart';

class ViewCartScreen extends StatefulWidget {
  const ViewCartScreen({super.key});

  @override
  State<ViewCartScreen> createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  @override
  Widget build(BuildContext context) {
    var prodProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Consumer<Products>(
        builder: (_, products, _c) {
          return FutureBuilder(
            future: products.items,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var productList = snapshot.data;

              print(productList);

              return ListView.builder(
                itemBuilder: (_, index) => productList![index].quantity > 0
                    ? Dismissible(
                        direction: DismissDirection.startToEnd,
                        key: UniqueKey(),
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Notice'),
                                  content:
                                      Text('Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        prodProvider.deletecart(
                                            productList[index], index);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(productList[index].nameDesc),
                            trailing:
                                Text(productList[index].quantity.toString()),
                          ),
                        ),
                      )
                    : Card(),
                itemCount: products.totalNoItems,
              );
            },
          );
        },
      ),
    );
  }
}
