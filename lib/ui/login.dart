import 'package:app_f/connections/connections.dart';
import 'package:app_f/helpers/exports.dart';
import 'package:app_f/providers/register.dart';
import 'package:app_f/widgets/loading.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "PDF CHAT BOT",
                          style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _password,
                        obscureText: obscure,
                        decoration: InputDecoration(
                            labelText: "Password",
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                icon: Icon(obscure
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/register",
                                    arguments: {
                                      "codigo": "este es el nombre del codigo"
                                    });
                              },
                              child: Text(
                                "Registrarse ahora!",
                                style: TextStyle(fontSize: 16),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_email.text.isNotEmpty &&
                                _password.text.isNotEmpty) {
                              getLoadingModal(context, false);

                              var response = await RegisterConnection().login(
                                  mail: _email.text, password: _password.text);

                              Navigator.pop(context);

                              if (response[0]) {
                                //TODO REDIRECT TO HOME
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/home", (route) => false);
                              } else {
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text: response[1].toString());
                              }

                              //TODO REGISTRO
                            } else {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: "Debes completar todos los campos");
                            }
                          },
                          child: Text(
                            "INGRESAR",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Text("DEVELOP BY FONLES")
          ],
        ),
      )),
    );
  }
}
