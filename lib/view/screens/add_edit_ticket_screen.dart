// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/controller/ticket_controller.dart';
import 'package:ticketing_system/model/ticket.dart';
import 'package:ticketing_system/view/screens/ticket_list_screen.dart';
import '../../controller/login_controller.dart';
import '../../controller/product_controller.dart';
import '../../controller/state_controller.dart';
import '../../controller/team_member_controller.dart';
import '../widgets/rounded_button.dart';

// ignore: must_be_immutable
class AddEditScreen extends StatefulWidget {
  bool isEdit = false;
  final Ticket? ticketDetail;
  AddEditScreen({super.key, required this.isEdit, this.ticketDetail});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  String? selectedProduct;
  String? selectedStatues;
  String? selectedMember;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TeamMemberController>(context, listen: false)
          .postGetAllTeamMember();
      Provider.of<StateController>(context, listen: false).postGetAllStatues();
      Provider.of<ProductController>(context, listen: false)
          .postGetAllProducts();

      if (widget.isEdit) {
        titleController =
            TextEditingController(text: widget.ticketDetail?.title);
        descriptionController =
            TextEditingController(text: widget.ticketDetail?.description);
        selectedProduct = "${widget.ticketDetail?.productId}";
        selectedMember = "${widget.ticketDetail?.assigneeId!}";
        selectedStatues = "${widget.ticketDetail?.stateId!}";
      }
    });
  }

  Future<void> _editTicketManger() async {
    widget.ticketDetail?.assigneeId = int.parse(selectedMember!);
    widget.ticketDetail?.stateId = int.parse(selectedStatues!);
    var provider = Provider.of<TicketController>(context, listen: false);
    await provider.postEditTicketManager(widget.ticketDetail);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(provider.message)));
    if (provider.isSuccess) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TicketListScreen()));
    }
  }

  Future<void> _editTicketTeamMember() async {
       String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    widget.ticketDetail?.title = title;
    widget.ticketDetail?.description = description;
    widget.ticketDetail?.stateId = int.parse(selectedStatues!);
    var provider = Provider.of<TicketController>(context, listen: false);
    await provider.postEditTicketTeamMember(widget.ticketDetail);
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(provider.message)));
    if (provider.isSuccess) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TicketListScreen()));
    }
  }

  Future<void> _editTicket() async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    widget.ticketDetail?.title = title;
    widget.ticketDetail?.description = description;
    var provider = Provider.of<TicketController>(context, listen: false);
    await provider.postEditTicket(widget.ticketDetail);
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(provider.message)));
    if (provider.isSuccess) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TicketListScreen()));
    }
  }

  Future<void> _addTicket() async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    var userData = Provider.of<LoginController>(context, listen: false);
    userData.getLoginData();
    Ticket ticket = Ticket(
        title: title,
        description: description,
        productId: int.parse(selectedProduct!),
        customerId: int.parse(userData.loginData.userId!),
        attachements: "NULL");
    var provider = Provider.of<TicketController>(context, listen: false);
    await provider.postAddTicket(ticket);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(provider.message)));
    if (provider.isSuccess) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TicketListScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<LoginController>(context, listen: true);
    userProvider.getLoginData();
    return Scaffold(
      
        body: Consumer<TicketController>(builder: (context, data, child) {
      return data.isLoading
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
          : SafeArea(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topCenter, colors: [
                  Color.fromARGB(255, 125, 180, 180),
                  Color.fromARGB(255, 117, 156, 188),
                ])),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                // const SizedBox(height: 20),
                                ticketBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                RoundedBottun(
                                  buttonText: 'Save',
                                  onPressed: () {
                                    if (widget.isEdit) {
                                      if (userProvider.loginData.roleId == 1) {
                                        _editTicketManger();
                                      } else if (userProvider
                                              .loginData.roleId ==
                                          2) {
                                        _editTicket();
                                      } else if (userProvider
                                              .loginData.roleId ==
                                          3) {
                                        _editTicketTeamMember();
                                      }
                                    } else {
                                      _addTicket();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    }));
  }

//*****************************ticket************************************* */

  Container ticketBox() {
    var userProvider = Provider.of<LoginController>(context, listen: true);
    var products =
        Provider.of<ProductController>(context, listen: false).productsList;

    userProvider.getLoginData();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          boxShadow: const [
            BoxShadow(
              blurRadius: 20,
              color: Color.fromARGB(255, 117, 156, 188),
              offset: Offset(0, 10),
            )
          ]),
      child: Column(
        children: <Widget>[
          Container(
            height: 45,
            margin: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: (userProvider.loginData.roleId != 1),
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Container(
            width: 320,
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1.0,
                  color: const Color.fromARGB(100, 1, 1, 1),
                )),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: widget.isEdit ? false : true,
                hint: Text(
                  "select product",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: products
                    .map((item) => DropdownMenuItem<String>(
                          enabled: widget.isEdit ? false : true,
                          value: item.id.toString(),
                          child: Text(
                            item.name!,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedProduct,
                onChanged: (String? value) {
                  setState(() {
                    selectedProduct = value!;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(bottom: 3.0),
            child: TextField(
              enabled: userProvider.loginData.roleId != 1,
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "problem description ?",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const Divider(
            height: 30,
            color: Colors.black,
          ),
          userProvider.loginData.roleId != 2 ? mangerEdit() : const SizedBox()
        ],
      ),
    );
  }

  Row mangerEdit() {
    var userProvider = Provider.of<LoginController>(context, listen: true);
     userProvider.getLoginData();
    var statues =
        Provider.of<StateController>(context, listen: false).statuesList;
    var teamMember = Provider.of<TeamMemberController>(context, listen: false)
        .teamMemberList;
    return Row(
      children: [
        userProvider.loginData.roleId == 1 ?
        Container(
          width: 170.0,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.0,
                color: const Color.fromARGB(100, 1, 1, 1),
              )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                "support team",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: teamMember
                  .map((item3) => DropdownMenuItem<String>(
                        value: item3.id.toString(),
                        child: Text(
                          item3.userName!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: selectedMember,
              onChanged: (String? value) {
                setState(() {
                  selectedMember = value!;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ) : const SizedBox(width: 3,) ,
        Container(
          width: 120.0,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.0,
                color: const Color.fromARGB(100, 1, 1, 1),
              )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                "select Statues",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: statues
                  .map((item2) => DropdownMenuItem<String>(
                        enabled: true,
                        value: item2.id.toString(),
                        child: Text(
                          item2.name!,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ))
                  .toList(),
              value: selectedStatues,
              onChanged: (String? value1) {
                setState(() {
                  selectedStatues = value1!;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
        // DropdownItems(
        //   itemList: const ['A', 'B', 'C'],
        //   textHint: "support team",
        //   width: 170.0,
        // ),
      ],
    );
  }
}
