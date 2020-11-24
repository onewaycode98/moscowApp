import 'package:flutter/material.dart';
import 'package:todoapp/core/models/CRUD_model.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/locator.dart';
import 'package:todoapp/ui/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => locator<CRUDModel>()),
        // ChangeNotifierProvider(create: (context) => CategoryData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
