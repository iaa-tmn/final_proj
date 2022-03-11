
import 'package:flutter/material.dart';

import 'arguments.dart';

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  User(
      {required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.address,
        required this.phone,
        required this.website,
        required this.company});

 factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        username:json['username'],
        email: json['email'],
        address:
        json['address'] != null ? new Address.fromJson(json['address']) : null,
        phone: json['phone'],
        website: json['website'],
        company:
        json['company'] != null ? new Company.fromJson(json['company']) : null);
  }

}

class Address {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  Address({required this.street, required this.suite, required this.city, required this.zipcode, required this.geo});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: json['geo'] != null ? new Geo.fromJson(json['geo']) : null);
  }

}

class Geo {
  final String? lat;
  final String? lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(lat : json['lat'],
    lng : json['lng']);
  }

}

class Company {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  Company({required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(name : json['name'],
    catchPhrase : json['catchPhrase'],
    bs : json['bs']);
  }

}

class userCard extends StatelessWidget {
  const userCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskScreenArguments args = ModalRoute.of(context)!.settings.arguments as TaskScreenArguments;
    final User user=args.user;
    return Column(
      children: [
        Text("ФИО: ${user.name}",style: Theme.of(context).textTheme.headline3),
        Text("Email: ${user.email}",style: Theme.of(context).textTheme.headline4),
        Text("Телефон: ${user.phone}",style: Theme.of(context).textTheme.headline4),
        Text("Website: ${user.website}",style: Theme.of(context).textTheme.headline6),
        Text("Company: ${user.company!.name}",style: Theme.of(context).textTheme.headline4),
        Text("Address: ${user.address!.zipcode} ${user.address!.city} ${user.address!.street} ${user.address!.suite}",style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}

