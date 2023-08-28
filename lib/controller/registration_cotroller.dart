import 'package:flutter/cupertino.dart';
import '../model/user.dart';
import 'package:ticketing_system/services/ticket_system_service.dart';

class RegistrationController extends ChangeNotifier {
  bool loading = false;
  late bool isSuccess;
  String message = "";
  Future<void> postRegister(User user) async {
    loading = true;
    notifyListeners();
    message = (await register(user))!;
    if (message == "You are Registerd Correctly!") {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    loading = false;
    notifyListeners();
  }
}
