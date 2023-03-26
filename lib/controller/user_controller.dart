import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  late Results _userResult;

  List<Results> _userLists = [];

  List<Results> get userList {
    return [..._userLists];
  }

  Future<bool?> getSastagramDeals() async {
    final url = Uri.https('randomuser.me', '/api/');

    List<Results> loadedUser = [];

    final response = await http.get(url).timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body);

      userData['results'].forEach((prodData) {
        print(prodData['picture']['large']);
        loadedUser.add(Results(
            gender: prodData['gender'],
            fullName: prodData['name']['title'] +
                " " +
                prodData['name']['first'] +
                prodData['name']['last'],
            country: prodData['location']['country'],
            smallImage: prodData['picture']['medium'],
            largeImage: prodData['picture']['large'],
            dateRegistered: prodData['registered']['date'],
            dateOfBirth: prodData['dob']['date'],
            city: prodData['location']['city'],
            state: prodData['location']['state'],
            postalcode: prodData['location']['postcode'].toString(),
            email: prodData['email'],
            phone: prodData['phone'],
            cell: prodData['cell'],
            nat: prodData['nat']));
      });
      _userLists.addAll(loadedUser);
      notifyListeners();
    }
  }
}
