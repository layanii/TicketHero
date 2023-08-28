// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing_system/controller/ticket_controller.dart';
import 'package:ticketing_system/view/screens/add_edit_ticket_screen.dart';
import 'package:ticketing_system/view/widgets/ticket_tile.dart';
import '../../controller/login_controller.dart';
import '../../model/login_data.dart';
import 'menubar_screen.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
      var loginData = LoginData.fromJson(json);
      if (loginData.roleId == 1) {
        Provider.of<TicketController>(context, listen: false)
            .postGetAllTicketManager();
      } else if (loginData.roleId == 3) {
        Provider.of<TicketController>(context, listen: false)
            .postGetAllTicketsTeamMember();
      } else {
        Provider.of<TicketController>(context, listen: false)
            .postGetAllTicketUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginController>(context, listen: true);
    provider.getLoginData();
    return Scaffold(
        floatingActionButton: provider.loginData.roleId == 2
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEditScreen(
                              isEdit: false,
                            )),
                  );
                },
                backgroundColor: Colors.blueGrey,
                child: const Icon(Icons.add),
              )
            : null,
        drawer: const UserMenu(),
        appBar: AppBar(
          title: const Text("Tickets list"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Consumer<TicketController>(
          builder: (context, value, child) {
            // If the loading it true then it will show the circular progressbar
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final tickets = value.ticketsList;
            return ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TicketTile(
                        t1: ticket.title.toString(), id: ticket.id.toString()),
                  );
                });
          },
        ));
  }
}
