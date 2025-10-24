import 'package:ecom_page/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;

  Stripe.publishableKey =
      'pk_test_51RvMrfGYtPYZ3CFKHA8VWJ79IhTRD88AvPol92f4GFPhowMsyoeb9Ps5puwQE53TQYq8ysxueb07GwWXMFr0MdgO00llrytheT';

  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}
