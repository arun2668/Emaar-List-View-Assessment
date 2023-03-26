import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

import '../model/user_model.dart';

class userDetail extends StatelessWidget {
  final Results? userResult;
  const userDetail({this.userResult});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(userResult!.dateRegistered!);
    String timeAgo = timeago.format(dateTime);

    final DateTime date = DateTime.parse(userResult!.dateOfBirth!);
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String formattedDate = formatter.format(date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text(userResult!.fullName!),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(userResult!.largeImage!),
              ),
              Divider(),
              Text("Email :" + userResult!.email!),
              SizedBox(
                height: 10,
              ),
              Text("DateJoined :" + timeAgo),
              SizedBox(
                height: 10,
              ),
              Text("Dob :" + formattedDate),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Text("City :" + userResult!.city!),
              SizedBox(
                height: 10,
              ),
              Text("State :" + userResult!.state!),
              SizedBox(
                height: 10,
              ),
              Text("Country :" + userResult!.country!),
              SizedBox(
                height: 10,
              ),
              Text("PostCode :" + userResult!.postalcode!),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
