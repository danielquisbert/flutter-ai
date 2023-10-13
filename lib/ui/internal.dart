import 'package:flutter/material.dart';

class InternalPage extends StatefulWidget {
  const InternalPage({super.key});

  @override
  State<InternalPage> createState() => _InternalPageState();
}

class _InternalPageState extends State<InternalPage> {
  String response = "Sin respuesta";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("CHAT CON EL PDF"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "Inserta tu pregunta sobre el PDF!"),
                ),
              ],
            ),
          ),
          Expanded(
              child: Material(
            elevation: 5,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 235, 235),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Text(response),
                ),
              ),
            ),
          ))
        ],
      )),
    );
  }
}
