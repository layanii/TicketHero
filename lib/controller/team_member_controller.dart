import 'package:flutter/material.dart';
import 'package:ticketing_system/model/user.dart';
import 'package:ticketing_system/services/ticket_system_service.dart';


class TeamMemberController extends ChangeNotifier {
  List<User> teamMemberList = [];
   List<User> clientList = [];
  bool isLoading = false;

  postGetAllTeamMember() async {
    isLoading = true;
    teamMemberList = (await getAllTeamMembers());
    isLoading = false;
    notifyListeners();
  }

  postGetAllclient() async {
    isLoading = true;
    clientList = (await getAllClient());
    isLoading = false;
    notifyListeners();
  }
}
