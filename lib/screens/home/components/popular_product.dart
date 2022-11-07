import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/repositories/product_repository.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  ProductRepository _productRepository = ProductRepository();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: SectionTitle(title: "Products / Services", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constrainted) {
          double fullWidth = (constrainted.maxWidth - 40);
          double productWidth = fullWidth > 500 ? fullWidth / 3 : fullWidth / 2;
          return FutureBuilder<List<ProductModel>?>(
            future: _productRepository.getList({}), // async work
            builder: (BuildContext context, AsyncSnapshot<List<ProductModel>?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return Text('Loading....');
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  print(snapshot.data!.length);
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        ...List.generate(
                          snapshot.data!.length,
                          (index) {
                            return ProductCard(product: snapshot.data![index], width: productWidth);
                          },
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    ),
                  );
                }
              },
            );
          }
        )
      ],
    );
  }
}
