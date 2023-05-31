import 'dart:typed_data';

import 'package:local_storage/database/global/global_field.dart';

class ProductModel {
  late int id;
  late String name;
  //final Uint8List image;
  late String image;
  late double price;
  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image});
  // Covert object to Map
  Map<String, dynamic> toMap() {
    return {
      fId: id,
      fName: name,
      fPrice: price,
      fIamage: image,
    };
  }

//  Convert Map to Object
  ProductModel.fromMap(Map<String, dynamic> res)
      : id = res[fId],
        name = res[fName],
        price = res[fPrice],
        image = res[fIamage];
}
