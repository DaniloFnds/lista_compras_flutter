import 'package:flutter/material.dart';
import 'package:lista_compras/router.dart';
import 'package:nuvigator/next.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: InkWell(child: Icon(Icons.people),),
          )],
          title: Text('Lista de Compras'),
        ),
        body: Nuvigator(
          router: MyRouter(),
        ),
      ),
    );
  }
}
