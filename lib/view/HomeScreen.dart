import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_poject3/services/store_services.dart';
import 'package:mini_poject3/view/ProductScreen.dart';
import 'package:mini_poject3/Colors.dart';

import '../services/auth_service.dart';
import 'LoginScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController phoneController = TextEditingController();
  final Categories = <String>[];
  final AuthService authService = AuthService();

  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  Future<void> loadCategories() async {
    final service = StoreServices();
    final result = await service.loadCategories();
    if (result != null) {
      setState(() {
        Categories.assignAll(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Column(
              children: [
                Icon(
                  Icons.output_rounded,
                  color: ConstantColors.errormess,
                  size: 25,
                ),
                Expanded(
                  child: Text(
                    'logout',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              if (Categories.isEmpty)
                Center(child: CircularProgressIndicator())
              else
                Column(
                  children: [
                    for (int i = 0; i < Categories.length; i++)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Productscreen(category: Categories[i]),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Categories[i],
                                style: TextStyle(
                                  color: ConstantColors.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: ConstantColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
