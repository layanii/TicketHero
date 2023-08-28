class LoginData {
  String? token;
  String? message;
  int? roleId;
  String? userId;
  String? name;
  String? email;

  LoginData({this.token, this.message, this.roleId, this.userId , this.email,this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> loginData = <String, dynamic>{};
    loginData['token'] = token;
    loginData['message'] = message;
    loginData['roleId'] = roleId;
    loginData['userId'] = userId;
    loginData['name'] = name;
    loginData['email'] = email;
    return loginData;
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
        token: json['token'],
        message: json['message'],
        roleId: json['roleId'],
        userId: json['userId'],
         name: json['name'],
        email: json['email']
        
        );
  }
}
