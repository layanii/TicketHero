// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/view/screens/team_member_list_screen.dart';
import 'package:ticketing_system/view/screens/ticket_list_screen.dart';
import 'package:ticketing_system/view/screens/login_screen.dart';
import 'package:ticketing_system/view/screens/registration_screen.dart';
import '../../controller/login_controller.dart';
import 'client_list_screen.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginController>(context, listen: true);
    provider.getLoginData();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
                provider.loginData != null ? provider.loginData.name! : ''),
            accountEmail: Text(
                provider.loginData != null ? provider.loginData.email! : ''),
            decoration: const BoxDecoration(color: Colors.blueGrey),
          ),
          ListTile(
              leading: const Icon(Icons.list_outlined),
              title: const Text("Tickets list"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TicketListScreen()));
              }),
          provider.loginData.roleId == 1
              ? ListTile(
                  leading: const Icon(Icons.people_alt_outlined),
                  title: const Text("Support member registration"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  Registration(roleId: 3,)));
                  })
              : const Divider(),
                 provider.loginData.roleId == 1
              ? ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text("Support members list"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TeamMemberScreen()));
                  })
              : const SizedBox(height: 1,),
               provider.loginData.roleId == 1
              ? ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text("Clients list"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ClientScreen()));
                  })
              : const SizedBox(height: 1,),
          ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text("Log out"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              }),
        ],
      ),
    );
  }
}
