import 'package:app_f/connections/connections.dart';
import 'package:app_f/helpers/exports.dart';
import 'package:app_f/widgets/loading.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscure = true;
  bool accept = false;
  final TextEditingController _names = TextEditingController();
  final TextEditingController _lastNames = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://github.com/flutter/packages/blob/main/packages/url_launcher/url_launcher/LICENSE'));

  @override
  void initState() {
    super.initState();
  }

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
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                          Expanded(
                            child: Text(
                              "PDF CHAT BOT",
                              style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Registro",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _names,
                        decoration:
                            InputDecoration(labelText: "Nombres completos"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _lastNames,
                        decoration:
                            InputDecoration(labelText: "Apellidos completos"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _mail,
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
                        height: 10,
                      ),
                      TextField(
                        controller: _city,
                        decoration: InputDecoration(labelText: "Ciudad"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: accept,
                              onChanged: (value) {
                                setState(() {
                                  accept = !accept;
                                });
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  // launchUrl(Uri.parse(
                                  //     "https://github.com/flutter/packages/blob/main/packages/url_launcher/url_launcher/LICENSE"));

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.all(0.0),
                                          title: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Terminos y Condiciones",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      color: Colors.transparent,
                                                      child: Icon(Icons.close)))
                                            ],
                                          ),
                                          content: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Container(
                                              child: WebViewWidget(
                                                  controller: controller),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                    "Al registrarte Aceptas nuestros terminos y condiciones")),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Inicia Sesión ahora",
                                style: TextStyle(fontSize: 16),
                              ))),
                      ElevatedButton(
                          onPressed: () async {
                            if (_names.text.isNotEmpty &&
                                _lastNames.text.isNotEmpty &&
                                _password.text.isNotEmpty &&
                                _mail.text.isNotEmpty &&
                                _city.text.isNotEmpty) {
                              if (!accept) {
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text:
                                        "Debes aceptar nuestros terminos y condiciones");
                                return;
                              }
                              getLoadingModal(context, false);

                              var response = await RegisterConnection()
                                  .registerUser(
                                      namesAndLastnames:
                                          _names.text + " " + _lastNames.text,
                                      mail: _mail.text,
                                      password: _password.text,
                                      city: _city.text);

                              Navigator.pop(context);

                              if (response[0]) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: "Registro Correcto",
                                  onConfirmBtnTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, "/login", (route) => false);
                                  },
                                );
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
                            "REGISTRARSE",
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
