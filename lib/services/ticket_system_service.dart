// ignore_for_file: avoid_print
// all apis of the system 
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_data.dart';
import '../model/product.dart';
import '../model/state.dart';
import '../model/ticket.dart';
import '../model/user.dart';

String baseUrl = "http://16.16.56.214:5152/api";
late SharedPreferences prefs;

Future<String?> register(User user) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse("$baseUrl/User/register"),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(user.toJson()));
    var data = jsonDecode(response.body);
    return data["message"];
  } catch (e) {
    return e.toString();
  }
}

Future<LoginData?> login(User user) async {
  http.Response? response;
  LoginData? loginData;
  try {
    loginData = LoginData();
    response = await http.post(Uri.parse("$baseUrl/User/login"),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(user.toJson()));
    loginData = LoginData.fromJson(jsonDecode(response.body));
  } catch (e) {
    loginData?.message = e.toString();
  }
  return loginData;
}

/// *****************************ticket***************************************

Future<List<Ticket>> getAllTickets() async {
  List<Ticket> ticketsList = [];
  prefs = await SharedPreferences.getInstance();
  http.Response? response;
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response = await http.get(
        Uri.parse("$baseUrl/Ticket/GetAllTickets/${loginData.userId}"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
        });
    for (var ticket in jsonDecode(response.body)) {
      ticketsList.add(Ticket.fromJson(ticket));
    }
  } catch (e) {
    print(e.toString());
  }
  return ticketsList;
}

Future<String?> addTicket(Ticket ticket) async {
  http.Response? response;
  prefs = await SharedPreferences.getInstance();
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response = await http.post(Uri.parse("$baseUrl/Ticket/AddTicket"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
        },
        body: jsonEncode(ticket.toJson()));
         print("add ticket json: ${ticket.toJson()}");
    var data = jsonDecode(response.body);
    return data["message"];
  } catch (e) {
    return e.toString();
  }
}

Future<Ticket?> ticketView(int id) async {
  Ticket? ticketsDetails;
  prefs = await SharedPreferences.getInstance();
  http.Response? response;
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    // "$baseUrl/Ticket/View/$id"
    response =
        await http.get(Uri.parse("$baseUrl/Ticket/ViewTicket/$id"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
    });
    ticketsDetails = Ticket.fromJson(jsonDecode(response.body));
  } catch (e) {
    print(e.toString());
  }
  return ticketsDetails;
}

Future<Ticket?> editTicket(Ticket ticket) async {
  Ticket? editTicket;
  prefs = await SharedPreferences.getInstance();
  http.Response? response;
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response =
        await http.put(Uri.parse("$baseUrl/Ticket/EditTicket/${ticket.id}"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
            },
            body: jsonEncode(ticket.toJson()));
    editTicket = Ticket.fromJson(jsonDecode(response.body));
  } catch (e) {
    print(e.toString());
  }
  return editTicket;
}

//*****************************Manager*************************************** */
Future<List<Ticket>> getAllTicketsManager() async {
  List<Ticket> ticketsList = [];
  prefs = await SharedPreferences.getInstance();
  http.Response? response;
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response =
        await http.get(Uri.parse("$baseUrl/Manager/GetAllTickets"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
    });
    for (var ticket in jsonDecode(response.body)) {
      ticketsList.add(Ticket.fromJson(ticket));
    }
  } catch (e) {
    print(e.toString());
  }
  return ticketsList;
}

Future<String?> editTicketManager(Ticket ticket) async {
  http.Response? response;

  prefs = await SharedPreferences.getInstance();
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response = await http.post(
        Uri.parse(
            "$baseUrl/Manager/EditTicket?asigneeId=${ticket.assigneeId}&ticketId=${ticket.id}&statusId=${ticket.stateId}"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
        },
        body: jsonEncode(ticket.toJson()));
    return response.body;
  } catch (e) {
    return e.toString();
  }
}

Future<List<Product>> getAllProducts() async {
  List<Product> productsList = [];
  prefs = await SharedPreferences.getInstance();
  http.Response? response;
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response =
        await http.get(Uri.parse("$baseUrl/Product/GetAllProducts"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
    });
    for (var product in jsonDecode(response.body)) {
      productsList.add(Product.fromJson(product));
    }
  } catch (e) {
    print(e.toString());
  }
  return productsList;
}

Future<List<State>> getAllStatues() async {
  List<State> statuesList = [];
  http.Response? response;
  prefs = await SharedPreferences.getInstance();
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response =
        await http.get(Uri.parse("$baseUrl/Manager/GetAllStatues"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
    });
    for (var statues in jsonDecode(response.body)) {
      statuesList.add(State.fromJson(statues));
    }
  } catch (e) {
    print(e.toString());
  }
  return statuesList;
}

Future<List<User>> getAllTeamMembers() async {
  List<User> members = [];
  http.Response? response;
  prefs = await SharedPreferences.getInstance();
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);

  try {
    response = await http
        .get(Uri.parse("$baseUrl/Manager/GetAllTeamMembers"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
    });
    for (var member in jsonDecode(response.body)) {
      members.add(User.fromJson(member));
    }
  } catch (e) {
    print(e.toString());
  }
  return members;
}

Future<List<User>> getAllClient() async {
  List<User> clients = [];
  http.Response? response;
  prefs = await SharedPreferences.getInstance();
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);

  try {
    response =
        await http.get(Uri.parse("$baseUrl/Manager/GetAllClients"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
    });
    for (var client in jsonDecode(response.body)) {
      clients.add(User.fromJson(client));
    }
  } catch (e) {
    print(e.toString());
  }
  return clients;
}

Future<String> activateUser(int id) async {
  http.Response? response;
  prefs = await SharedPreferences.getInstance();
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response = await http.post(Uri.parse("$baseUrl/Manager/ActivateUser/$id"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
        },
        );
    var data = jsonDecode(response.body);
    return data["message"];
  } catch (e) {
    return e.toString();
  }
}

Future<String> deactivateUser(int id) async {
  http.Response? response;
  prefs = await SharedPreferences.getInstance();
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response = await http.get(Uri.parse("$baseUrl/Manager/DeactivateUser/$id"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
        },);
    var data = jsonDecode(response.body);
    return data["message"];
  } catch (e) {
    return e.toString();
  }
}
//*****************************team members********************************** */

Future<List<Ticket>> getAllTicketsTeamMember() async {
  List<Ticket> ticketsList = [];
  prefs = await SharedPreferences.getInstance();
  http.Response? response;
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response = await http.get(
        Uri.parse("$baseUrl/TeamMember/GetAllTickets/${loginData.userId}"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
        });
    for (var ticket in jsonDecode(response.body)) {
      ticketsList.add(Ticket.fromJson(ticket));
    }
  } catch (e) {
    print(e.toString());
  }
  return ticketsList;
}

Future<Ticket?> editTicketTeamMember(Ticket ticket) async {
  Ticket? editTicket;
  prefs = await SharedPreferences.getInstance();
  http.Response? response;
  LoginData? loginData;
  Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
  print("json: $json");
  loginData = LoginData.fromJson(json);
  try {
    response =
        await http.put(Uri.parse("$baseUrl/TeamMember/EditTicket/${ticket.id}"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${loginData.token}"
            },
            body: jsonEncode(ticket.toJson()));
    editTicket = Ticket.fromJson(jsonDecode(response.body));
  } catch (e) {
    print(e.toString());
  }
  return editTicket;
}
