
import 'package:flutter/material.dart';
import 'package:ticketing_system/services/ticket_system_service.dart';


class ActivationController extends ChangeNotifier {
  String message= "";
  bool isLoading = false;
  late bool isSuccess;

  activation(int id) async {
  isLoading = true;
    notifyListeners();
    message = (await activateUser(id));
    if (message == "The user activation was successfully completed") {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    isLoading = false;
    notifyListeners();
  }
  
  deactivation(int id) async {
  isLoading = true;
    notifyListeners();
    message = (await deactivateUser(id));
    if (message == "The user deactivation was successfully completed") {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    isLoading = false;
    notifyListeners();
  }
  
}
