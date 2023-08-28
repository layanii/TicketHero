import 'package:flutter/material.dart';
import '../model/ticket.dart';
import '../services/ticket_system_service.dart';

class TicketController extends ChangeNotifier {
  List<Ticket> ticketsList = [];
  late bool isSuccess;
  bool isLoading = false;
  String message = "";
  Ticket? userTicket;
  Ticket? editedTicket;

  postGetAllTicketUser() async {
    isLoading = true;
    notifyListeners();
    ticketsList = (await getAllTickets());
    isLoading = false;
    notifyListeners();
  }

  postGetAllTicketsTeamMember() async {
    isLoading = true;
    notifyListeners();
    ticketsList = (await getAllTicketsTeamMember());
    isLoading = false;
    notifyListeners();
  }

  postGetAllTicketManager() async {
    isLoading = true;
    notifyListeners();
    ticketsList = (await getAllTicketsManager());
    isLoading = false;
    notifyListeners();
  }

  postViewUserTicket(int id) async {
    isLoading = true;
    notifyListeners();
    userTicket = await ticketView(id);
    isLoading = false;
    notifyListeners();
  }

  postEditTicket(Ticket? ticket) async {
    isLoading = true;
    notifyListeners();
    editedTicket = await editTicket(ticket!);
    if (editedTicket != null) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    isLoading = false;
    notifyListeners();
  }

  postEditTicketManager(Ticket? ticket) async {
    isLoading = true;
    notifyListeners();
    message = (await editTicketManager(ticket!))!;
    if (message == "Ticket assigned successfully") {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    isLoading = false;
    notifyListeners();
  }

  postEditTicketTeamMember(Ticket? ticket) async {
    isLoading = true;
    notifyListeners();
    editedTicket = await editTicketTeamMember(ticket!);
    if (editedTicket != null) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> postAddTicket(Ticket ticket) async {
    isLoading = true;
    notifyListeners();
    message = (await addTicket(ticket))!;
    if (message == "Ticket added successfully!") {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    isLoading = false;
    notifyListeners();
  }
}
