import 'package:flutter/material.dart';
import 'package:ticketing_system/services/ticket_system_service.dart';


class StateController extends ChangeNotifier {
  var statuesList = [];
  bool isLoading = false;

  postGetAllStatues() async {
    isLoading = true;
    statuesList = (await getAllStatues());
    isLoading = false;
    notifyListeners();
  }
}
