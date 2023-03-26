import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'user_detail.dart';

import '../controller/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // UserController userCont = UserController();

    List<Results> users = [];

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.getSastagramDeals();

      users = userProvider.userList;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('User List'),
      ),
      body: Consumer<UserProvider>(builder: (context, UserProvider, _) {
        return userProvider.userList != 0
            ? ListView.separated(
                itemCount: userProvider.userList.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime dateTime = DateTime.parse(
                      userProvider.userList[index].dateRegistered!);
                  String timeAgo = timeago.format(dateTime);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => userDetail(
                                  userResult: userProvider.userList[index],
                                )),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(
                          userProvider.userList[index].smallImage!),
                      title: Text(userProvider.userList[index].fullName!),
                      subtitle: Text(userProvider.userList[index].country!),
                      trailing: Text(timeAgo),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              )
            : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
