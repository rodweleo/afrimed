import 'package:AfriMed/pages/auth/auth.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:AfriMed/services/firebase_cloud_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AfriMed/providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FCMService().initialize();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'AfriMed',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors. blueGrey),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const Authenticator(),
      ),
    );
  }
}
