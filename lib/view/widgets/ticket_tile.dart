
import 'package:flutter/material.dart';
import '../screens/ticket_details_screen.dart';

class TicketTile extends StatelessWidget {
  const TicketTile({super.key, required this.t1 , required this.id});
  final String t1;
  final String id;
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
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
                child: Text(
                  id,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                t1,
                style: const TextStyle(
                  fontSize: 24, color: Colors.black54
                ),

              ),
              onLongPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TicketDetailScreen(ticketId: int.parse(id),)));
              }),
        ],
      ),
    );
  }
}
