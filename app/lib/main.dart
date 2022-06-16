import 'package:app/not_found.dart';
import 'package:app/providers/token.dart';
import 'package:app/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TokenProvider tokenProvider = TokenProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: tokenProvider)],
      child: MaterialApp(
        title: 'Swifty-companion',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const Home(),
        },
        onUnknownRoute: (_) =>
            MaterialPageRoute(builder: (_) => const NotFound()),
      ),
    );
  }
}
