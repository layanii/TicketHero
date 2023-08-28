class User {
  int? id;
  String? name;
  String? email;
  String? password;
  int? roleId;
  String? mobileNumber;
  String? address;
  String? dateOfBirth;
  String? userName;
  bool? isActive;
  int? numberOfTickets;

  User(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.dateOfBirth,
      this.isActive,
      this.mobileNumber,
      this.password,
      this.roleId,
      this.userName,
      this.numberOfTickets});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user['id'] = id;
    user['name'] = name;
    user['userName'] = userName;
    user['email'] = email;
    user['address'] = address;
    user['dateOfBirth'] = dateOfBirth;
    user['isActive'] = isActive;
    user['mobileNumber'] = mobileNumber;
    user['password'] = password;
    user['roleId'] = roleId;
    user['numberOfTickets'] = numberOfTickets;
    return user;
  }

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id: json?['id'],
      name: json?['name'],
      userName: json?['userName'],
      email: json?['email'],
      address: json?['address'],
      dateOfBirth: json?['dateOfBirth'],
      isActive: json?['isActive'],
      mobileNumber: json?['mobileNumber'],
      password: json?['password '],
      roleId: json?['roleId'],
      numberOfTickets : json?['numberOfTickets']
    );
  }
}
