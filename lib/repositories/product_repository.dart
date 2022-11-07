import 'dart:async';

import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/repositories/repository.dart';

class ProductRepository extends Repository {
  Future<List<ProductModel>?> getList(Map<String, String> params) async {
    await this.makeGet(API_URL+'/admin/products', parames: params);
    if (this.responseSuccess()) {
      List<ProductModel> items = [];
      for (var item in this.getResponse().data) {
        print(item);
        items.add(ProductModel.fromJson(item));
      }
      return items;
    }
    return null;
  }
}
