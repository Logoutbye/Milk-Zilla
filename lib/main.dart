import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:milk_zilla/View/Buyer_UI/helper.dart';
import 'package:milk_zilla/provider/Sopping_item_provider.dart';
import 'package:provider/provider.dart';
import 'View/my_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

// final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShoppingItemProvider(),
      child: MaterialApp(
        // navigatorKey: navigatorKey,
        title: 'Milk Zilla',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
        ),
        home:  MyHomePage(),
      ),
    );
  }
}
