import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../controller/ticket_controller.dart';
import 'add_edit_ticket_screen.dart';

class TicketDetailScreen extends StatefulWidget {
  final int ticketId;
  const TicketDetailScreen({super.key, required this.ticketId});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TicketController>(context, listen: false)
          .postViewUserTicket(widget.ticketId);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TicketController>(context, listen: true);
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: const Text("Ticket Details"),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddEditScreen(
                            isEdit: true,
                            ticketDetail: provider.userTicket,
                          )));
                },
                icon: const Icon(Icons.edit))
          ],
          bottom: PreferredSize(
              preferredSize: const Size(400, 300),
              child: provider.isLoading
                  ? Center(
                      child: SpinKitThreeBounce(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: index.isEven ? Colors.red : Colors.green,
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      width: 450,
                      height: 300,
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 21), //apply style to all
                                children: [
                              const TextSpan(
                                  text: "\nTitle: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: "${provider.userTicket?.title}"),
                              const TextSpan(
                                  text: "\nProduct: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      "${provider.userTicket?.product?.name}"),
                              const TextSpan(
                                  text: "\nTicket status: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "${provider.userTicket?.state?.name}"),
                              const TextSpan(
                                  text: "\nDescription: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "${provider.userTicket?.description}"),
                              const TextSpan(
                                  text: "\nSupervising employee: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                 text: provider.userTicket?.assignee?.name != null ? 
                                      "${provider.userTicket?.assignee?.name}" : "")
                            ])),
                      ))),
        ),
      ),

//       Positioned(
//               top: 200,
//               left:60,
//               child: Container(
//              width: 400,
//               height: 400,
//                 // color: Colors.white70,
//                 child: DropShadow(
//   blurRadius: 2,
//   offset: const Offset(3, 3),
//   spread: 1,
//   child: Image.network( "https://cdn.salla.sa/aeGQX/nPdMFSf6uS1Yu3CanDiuOIb41M5ddSAmyEoKiIt3.png"
//     ,
//     width: 280,
//   ),
// ),
//               ),
//             ),
    ]);
  }
}
