import 'package:app_f/helpers/exports.dart';
import 'package:app_f/providers/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefsMain;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefsMain = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat PDF BOT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/login",
      routes: getRoutes(),
    );
  }
}
