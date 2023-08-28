import 'dart:core';

import 'package:ticketing_system/model/product.dart';
import 'package:ticketing_system/model/state.dart';
import 'package:ticketing_system/model/user.dart';

class Ticket {
  int? id;
  String? title;
  String? description;
  String? attachements;
  State? state;
  int? stateId;
  int? status;
  int? assigneeId;
  int? productId;
  int? customerId;
  User? assignee;
  Product? product;
  User? customer;

  Ticket(
      {this.id,
      this.title,
      this.description,
      this.attachements,
      this.status,
      this.stateId,
      this.state,
      this.assigneeId,
      this.productId,
      this.customerId,
      this.assignee,
      this.customer,
      this.product});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ticket = <String, dynamic>{};
    ticket['id'] = id;
    ticket['title'] = title;
    ticket['description'] = description;
    ticket['status'] = status;
    ticket['assigneeId'] = assigneeId;
    ticket['productId'] = productId;
    ticket['customerId'] = customerId;
    ticket['attachments'] = attachements;
    ticket['state'] = state;
    ticket['stateId'] = stateId;
    ticket['assignee'] = assignee;
     ticket['product'] = product;
    ticket['customer'] = customer;
    return ticket;
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      state: State.fromJson(json['state']),
      stateId: json['stateId'],
      assigneeId: json['assigneeId'],
      productId: json['productId'],
      customerId: json['customerId'],
      attachements: json['attachments'],
      assignee: User.fromJson(json['assignee']),
      customer: User.fromJson(json['customer']),
      product: Product.fromJson(json['product']),
      //return object of 
    );
  }
}
