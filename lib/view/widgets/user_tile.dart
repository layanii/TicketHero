// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/activation_controller.dart';

class UserTile extends StatefulWidget {
  const UserTile({super.key, required this.t1, required this.id , required this.client , this.ticketnum});
  final String t1;
  final String id;
  final bool client;
  final int? ticketnum;
  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  Future<void> activion() async {
    var provider = Provider.of<ActivationController>(context, listen: false);

    await provider.activation(int.parse(widget.id));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(provider.message)));
  }

  Future<void> deactivion() async {
    var provider = Provider.of<ActivationController>(context, listen: false);

    await provider.deactivation(int.parse(widget.id));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(provider.message)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(199, 142, 182, 202),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              alignment: Alignment.center,
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.white),
              child: Text(
                widget.id,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              widget.t1,
              style: const TextStyle(fontSize: 24, color: Colors.black54),
            ),
            trailing: Column(
              children: [
                InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    activion();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: const Text(
                      "Activate",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    deactivion();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: const Text(
                      "Deactivate",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            subtitle: widget.client ? Text("No. of tickets : ${widget.ticketnum}" , style: const TextStyle(color: Colors.black87 , fontSize:18),) : null,
          ),
        ],
      ),
    );
  }
}
