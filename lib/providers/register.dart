import 'package:app_f/helpers/exports.dart';

class RegisterProvider extends ChangeNotifier{
  final TextEditingController _names = TextEditingController();

  getName(){
    return _names;
  }

  // setName(String newName){
  //   _name = newName;
  //   notifyListeners();
  // }
}