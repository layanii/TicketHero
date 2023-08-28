import 'package:flutter/material.dart';
import 'package:ticketing_system/view/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'controller/activation_controller.dart';
import 'controller/login_controller.dart';
import 'controller/product_controller.dart';
import 'controller/registration_cotroller.dart';
import 'controller/state_controller.dart';
import 'controller/team_member_controller.dart';
import 'controller/ticket_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => RegistrationController()),
    ChangeNotifierProvider(create: (_) => LoginController()),
    ChangeNotifierProvider(create: (_) => TicketController()),
    ChangeNotifierProvider(create: (_) => ProductController()),
    ChangeNotifierProvider(create: (_) => StateController()),
    ChangeNotifierProvider(create: (_) => TeamMemberController()),
    ChangeNotifierProvider(create: (_) => ActivationController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
