import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing_system/model/login_data.dart';
import '../model/user.dart';
import 'package:ticketing_system/services/ticket_system_service.dart';

class LoginController extends ChangeNotifier {
  bool loading = false;
  late bool isSuccess;
  String? message = "";
  late SharedPreferences prefs;
  LoginData loginData = LoginData();

  void saveLoginData(LoginData data) async {
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> decodedToken = JwtDecoder.decode(data.token!);
    data.userId = decodedToken["UserId"];
    data.name = decodedToken["DisplayName"];
    data.email = decodedToken["Email"];
    var loginDataJson = jsonEncode(data.toJson());
    prefs.setString('loginData', loginDataJson);
  }

  void getLoginData() async {
    prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> json = jsonDecode(prefs.getString('loginData')!);
    loginData = LoginData.fromJson(json);
    notifyListeners();
  }

  Future<void> postLogin(User user) async {
    loading = true;
    notifyListeners();
    LoginData response = (await login(user))!;
    message = response.message;
    if (response.message == "Login Succefully") {
      isSuccess = true;
      saveLoginData(response);
    } else {
      isSuccess = false;
    }
    loading = false;
    notifyListeners();
  }
}
