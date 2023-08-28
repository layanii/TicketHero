// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:ticketing_system/view/screens/login_screen.dart';
import 'package:ticketing_system/view/screens/ticket_list_screen.dart';
import '../../controller/registration_cotroller.dart';
import '../../model/user.dart';
import '../widgets/rounded_button.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Registration extends StatefulWidget {
  var roleId = 2;
   Registration({super.key, required this.roleId});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var dateController = TextEditingController();
  late DateTime _date;

  Future<void> _registration() async {
    String name = fullnameController.text.trim();
    String phone = phoneController.text.trim();
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String addreess = addressController.text.trim();
    var date = _date;

    User user = User(
        name: name,
        email: email,
        password: password,
        mobileNumber: phone,
        address: addreess,
        userName: username,
        isActive: true,
        roleId: widget.roleId,
        dateOfBirth: DateFormat("yyyy-MM-ddTHH:mm:ss").format(date));

    var provider = Provider.of<RegistrationController>(context, listen: false);
    await provider.postRegister(user);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(provider.message)));
    if (provider.isSuccess) {
      if (widget.roleId == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TicketListScreen()));
      }
    }
  }

  bool _emailValidtion = false;
  late String email;
  // String urlimg = "https://cdn-icons-png.flaticon.com/512/1057/1057240.png";
  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //   });
  // }
// Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<RegistrationController>(builder: (context, data, child) {
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
                    const SizedBox(height: 40),
                    // InkWell(
                    //   onTap: selectImage,
                    //   child: _image != null
                    //       ? CircleAvatar(
                    //           radius: 54,
                    //           backgroundImage: MemoryImage(_image!),
                    //           backgroundColor:
                    //               const Color.fromARGB(255, 117, 156, 188),
                    //         )
                    //       : CircleAvatar(
                    //           radius: 54,
                    //           backgroundImage: NetworkImage(urlimg),
                    //         ),
                    // ),
                    const SizedBox(height: 30),
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
                                const SizedBox(height: 20),
                                registrationBox(),
                                const SizedBox(
                                  height: 30,
                                ),
                                //-------------------------------button-------------------------------------
                                RoundedBottun(
                                  buttonText: 'Register',
                                  onPressed: () {
                                    if (_emailValidtion == false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("invalied email")));
                                    } else {
                                      _registration();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const LoginScreen()));
                                    }
                                  },
                                ),
                                const SizedBox(height: 40),
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

  /// *********************************Registration-info**************************************************

  Container registrationBox() {
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
      child: Consumer<RegistrationController>(
        builder: (context, ticket, child) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: fullnameController,
                  decoration: const InputDecoration(
                      hintText: "Full name", suffixIcon: Icon(Icons.people)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  // validator: ((value) {
                  //   if (value!.isEmpty) {
                  //     return "please enter value";
                  //   }
                  //   return null;
                  // }),
                  decoration: const InputDecoration(
                      hintText: "email", suffixIcon: Icon(Icons.email)),
                  onChanged: (valu) {
                    setState(() {
                      _emailValidtion = EmailValidator.validate(valu);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      hintText: "username", suffixIcon: Icon(Icons.person)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "password", suffixIcon: Icon(Icons.password)),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      hintText: "Address",
                      suffixIcon: Icon(Icons.location_pin)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                      hintText: "Date of birth",
                      suffixIcon: Icon(Icons.calendar_today)),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2024));

                    if (pickedDate != null) {
                      setState(() {
                        _date = pickedDate;
                        dateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntlPhoneField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    phone.completeNumber;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
