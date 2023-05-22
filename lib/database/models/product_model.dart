import 'package:local_storage/database/global/global_field.dart';

class ProductModel {
  late int id;
  late String name;
  ProductModel({required this.id, required this.name});
  Map<String, dynamic> toMap() {
    return {fId: id, fName: name};
  }

  ProductModel.fromMap(Map<String, dynamic> res)
      : id = res[fId],
        name = res[fName];
}
