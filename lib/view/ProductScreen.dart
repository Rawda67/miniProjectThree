import 'package:flutter/material.dart';
import '../Colors.dart';
import '../models/ProductResponce.dart';
import '../services/store_services.dart';

class Productscreen extends StatefulWidget {
  final String category;

  Productscreen({super.key, required this.category});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  ProductResponce? productResp;
  Set<int> favoriteProductIds = {};

  @override
  void initState() {
    super.initState();
    loadProductByCategory();
  }

  Future<void> loadProductByCategory() async {
    final service = StoreServices();
    final result = await service.loadProductsByCategory(widget.category);
    print('Result: $result');
    if (result != null) {
      setState(() {
        productResp = result;
      });
    } else {
      print('Failed to load data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products in ${widget.category}')),
      body:
          productResp == null
              ? Center(child: CircularProgressIndicator())
              : productResp!.products.isEmpty
              ? Center(child: Text('No products available in this category.'))
              : RefreshIndicator(
                onRefresh: loadProductByCategory,
                child: ListView.builder(
                  itemCount: productResp!.products.length,
                  itemBuilder: (ctx, index) {
                    final product = productResp!.products[index];
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(5),
                      height: 170,
                      color: Colors.black12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.network(
                                product.thumbnail,
                                height: 170,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                height: 42,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: EdgeInsets.all(5),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (favoriteProductIds.contains(
                                        product.id,
                                      )) {
                                        favoriteProductIds.remove(product.id);
                                      } else {
                                        favoriteProductIds.add(product.id);
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    favoriteProductIds.contains(product.id)
                                        ? Icons.favorite
                                        : Icons.favorite_outline_outlined,
                                    color: ConstantColors.primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 24,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "(${product.rating})",
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "\$${product.price}",
                                  style: TextStyle(
                                    color: ConstantColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
