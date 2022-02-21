// @dart=2.9
import 'package:agritech/products_screen/products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'commands_screen/commands_screen.dart';
import 'home_page/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDzE47A0T4qoZ55RMYZTKrqcwO7LnHbY_c",
        authDomain: "agritech-779a3.firebaseapp.com",
        projectId: "agritech-779a3",
        storageBucket: "agritech-779a3.appspot.com",
        messagingSenderId: "475563610726",
        appId: "1:475563610726:web:4e6ec0d7470ca824a613a7"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/products", page: () => ProdctsScreen()),
        GetPage(name: "/commands", page: () => CommandsScreen()),
      ],
      title: 'Agri Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
