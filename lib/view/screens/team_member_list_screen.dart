import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/team_member_controller.dart';
import '../widgets/user_tile.dart';
import 'menubar_screen.dart';

class TeamMemberScreen extends StatefulWidget {
  const TeamMemberScreen({super.key});

  @override
  State<TeamMemberScreen> createState() => _TeamMemberScreenState();
}

class _TeamMemberScreenState extends State<TeamMemberScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TeamMemberController>(context, listen: false).postGetAllTeamMember();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const UserMenu(),
        appBar: AppBar(
          title: const Text("Team members"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Consumer<TeamMemberController>(
          builder: (context, value, child) {
            // If the loading it true then it will show the circular progressbar
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final memberList = value.teamMemberList;
            return ListView.builder(
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  final member = memberList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserTile(
                        t1: member.userName.toString(), id: member.id.toString(), client: false,),
                  );
                });
          },
        ));
  }
}
