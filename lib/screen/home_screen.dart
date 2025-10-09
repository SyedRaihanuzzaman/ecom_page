import 'package:ecom_page/model/ecom_model.dart';
import 'package:ecom_page/screen/cart_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EcomModel> cartListData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Product is ${cartListData.length}"),
        backgroundColor: Colors.cyan,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: products.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),

                  itemBuilder: (context, index) {
                    return Container(
                      height: 300,

                      //   color: Colors.blue,
                      child: Column(
                        children: [
                          Image.asset(
                            "${products[index].image}",
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "${products[index].name}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("৳ ${products[index].price}"),
                              InkWell(
                                onTap: () {
                                  try {
                                    cartListData.firstWhere(
                                      (element) =>
                                          element.id == products[index].id,
                                    );

                                    var snackbar = SnackBar(
                                      backgroundColor: Colors.cyan,
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                        "Data Already Added",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );

                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(snackbar);
                                  } catch (e) {
                                    cartListData.add(products[index]);
                                    setState(() {});
                                  }
                                },
                                child: Icon(Icons.shopping_cart),
                              ),
                            ],
                          ),

                          Text(
                            "${products[index].details}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CartScreen(cartDataList: cartListData),
                    ),
                  );
                },
                minWidth: double.infinity,
                color: Colors.cyan,
                child: Text("Go to Next Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
