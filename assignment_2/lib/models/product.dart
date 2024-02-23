import 'package:assignment_2/helpers/dbhelper.dart';

class Product {
  late String code;
  late String nameDesc;
  late double price;
  late bool isFavorite;
  late bool isCart;
  late int quantity;

  Product(
      {required this.code,
      required this.nameDesc,
      required this.price,
      this.isFavorite = false,
      this.isCart = false,
      required this.quantity});

  Product.fromMap(Map<String, dynamic> value) {
    code = value[DbHelper.prodCode];
    nameDesc = value[DbHelper.prodName];
    price = double.parse(value[DbHelper.prodPrice].toString());
    isFavorite = value[DbHelper.prodisfav] == 1;
    isCart = value[DbHelper.prodiscart] == 1;
    quantity = int.parse(value[DbHelper.prodquantity].toString());
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.prodCode: code,
      DbHelper.prodName: nameDesc,
      DbHelper.prodPrice: price,
      DbHelper.prodisfav: isFavorite,
      DbHelper.prodiscart: isCart,
      DbHelper.prodquantity: quantity
    };
  }
}
