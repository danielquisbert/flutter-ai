import 'package:app_f/helpers/exports.dart';
import 'package:app_f/ui/home.dart';
import 'package:app_f/ui/internal.dart';
import 'package:app_f/ui/register.dart';

getRoutes() {
  return {
    "/login": (context) => LoginPage(),
    "/register": (context) => RegisterPage(),
    "/home": (context) => HomePage(),
    "/home/internal": (context) => InternalPage(),
  };
}
