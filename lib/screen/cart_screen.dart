import 'dart:convert';

import 'package:ecom_page/model/ecom_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  CartScreen({super.key, this.cartDataList});

  List<EcomModel>? cartDataList = [];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var netTotal = 0;
  void getTotal() {
    netTotal = widget.cartDataList!
        .map((item) => item.price!.toInt() * item.quantity)
        .reduce((value, element) => value + element);
  }

  @override
  void initState() {
    getTotal();
    super.initState();
  }

  // ✅ Create Payment Intent (temporary test method)
  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'automatic_payment_methods[enabled]': 'true',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51RvMrfGYtPYZ3CFKYANA9cDvSeDCQNHJjIp05knyguBg2loiOOhWmYUwFgL3C1UbJYNJtf07o0zH3csRGVbAexXV00c0qmyJGP',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating payment intent: $e');
    }
  }

  // ✅ Payment handler
  Future<void> payNow() async {
    try {
      getTotal();
      if (netTotal <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Cart is empty!")));
        return;
      }

      String amount = (netTotal * 100).toInt().toString(); // Stripe needs cents

      final paymentData = await createPaymentIntent(amount, 'usd');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentData['client_secret'],
          merchantDisplayName: 'My Test Store',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('✅ Payment Successful!')));
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Payment cancelled: ${e.error.localizedMessage}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('⚠️ Error: $e')));
    }
  }

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

                        InkWell(
                          onTap: () {
                            widget.cartDataList![index].quantity--;
                            getTotal();
                            setState(() {});
                          },
                          child: Icon(Icons.remove),
                        ),

                        Text("${widget.cartDataList![index].quantity}"),

                        InkWell(
                          onTap: () {
                            widget.cartDataList![index].quantity++;
                            getTotal();
                            setState(() {});
                          },
                          child: Icon(Icons.add),
                        ),

                        InkWell(onTap: () {}, child: Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              color: Colors.cyan.shade100,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ৳$netTotal",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Tooltip(
                    message: "Payment",
                    child: IconButton(
                      icon: Icon(Icons.payment_rounded, color: Colors.cyan),
                      onPressed: () async {
                        // await payNow();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
