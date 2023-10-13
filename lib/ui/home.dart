import 'package:app_f/connections/connections.dart';
import 'package:app_f/data/data.dart';
import 'package:app_f/main.dart';
import 'package:app_f/models/pdf_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PdfModel> data = [];
  @override
  void initState() {
    loadingData();
    super.initState();
  }

  loadingData() async {
    List<PdfModel> response = await Connections().getPdfsList();
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    sharedPrefsMain!.clear();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/login", (route) => false);
                  },
                  icon: Icon(Icons.logout_rounded),
                  color: Colors.redAccent,
                ),
              ),
              Divider(),
              Text(
                "Bienvenido: ${sharedPrefsMain!.getString("nameAndLastname")}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20),
              ),
              Text(
                "Busca dentro de nuestros PDFS",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 28),
              ),
              Divider(),
              ...List.generate(
                  data.length,
                  (index) => ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/home/internal');
                        },
                        leading: Container(
                          width: 70,
                          height: 80,
                          child: Image.network(
                            "https://images.unsplash.com/photo-1461710727236-2366afa21725?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2835&q=80",
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(data[index].title),
                        subtitle: Text(data[index].subtitle),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ))
            ],
          ),
        ),
      )),
    );
  }
}
