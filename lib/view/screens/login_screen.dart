// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/view/screens/ticket_list_screen.dart';
import '../../controller/login_controller.dart';
import '../../model/user.dart';
import '../widgets/rounded_button.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _logIn() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    User user = User(
      password: password,
      userName: username,
    );

    var provider = Provider.of<LoginController>(context, listen: false);
    await provider.postLogin(user);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(provider.message!)));
    if (provider.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TicketListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<LoginController>(
      builder: (context, data, child) {
        return data.loading
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
                      const SizedBox(
                          width: 270,
                          height: 220,
                          child: Image(
                            image: AssetImage('assets/Ticketing.png'),
                            color: Colors.white,
                          )),
                      const Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0, // shadow blur
                                color: Colors.white70, // shadow color
                                offset: Offset(
                                    2.0, 2.0), // how much shadow will be shown
                              ),
                            ]),
                      ),
                      const SizedBox(height: 20),
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
                                  loginBox(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  RoundedBottun(
                                    buttonText: 'Login',
                                    onPressed: () {
                                      _logIn();
                                    },
                                  ),

                                  const SizedBox(height: 40),
                                  Row(
                                    children: [
                                      const Text(
                                        "you don't have account? ",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                       Registration(roleId: 2,)));
                                        },
                                        child: const Text(
                                          "Register.",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )
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
      },
    ));
  }

//****************************************************************** */
  Container loginBox() {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "username",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "password",
              ),
              obscureText: true,
            ),
          ),
          // Container(
          //   alignment: Alignment.bottomRight,
          //   child: InkWell(
          //     child: const Text(
          //       "forgot password",
          //       style: TextStyle(color: Colors.blue),
          //     ),
          //     onTap: () {
          //       print("aaaa");
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

// ******************************Bottun**************************************

