import 'package:ecom_page/model/ecom_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key, this.cartDataList});

  List<EcomModel>? cartDataList = [];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total item is: ${widget.cartDataList!.length}"),
      ),

      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartDataList!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "${widget.cartDataList![index].image}",

                          height: 80,
                          width: 80,
                        ),

                        Text("${widget.cartDataList![index].name}"),
                        Text("${widget.cartDataList![index].price}"),
                        Icon(Icons.remove),

                        Text("${widget.cartDataList![index].quantity}"),

                        Icon(Icons.add),
                        Icon(Icons.delete),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
