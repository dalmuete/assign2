import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assignment_2/providers/cartprovider.dart';
import 'package:assignment_2/providers/productsprovider.dart';
import 'package:assignment_2/screens/viewproducts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartItems(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ViewProductsScreen(),
      ),
    );
  }
}
