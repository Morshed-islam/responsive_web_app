import 'package:flutter/material.dart';
import 'package:responsive_web_app/screens/add_money/user_list.dart';
import '../../responsive/responsive_widget.dart';
import '../../utils/app_constant.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('টাকা জমাা'),
      ),
      body: ResponsiveWidget(
        mobile: const UserList(),
        tablet: Container(alignment: Alignment.center, color: Colors.black12, child: Container(alignment: Alignment.center, margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 100), color: Colors.black12, child: const UserList())),
        web: Container(alignment: Alignment.center, color: Colors.black12, child: Container(alignment: Alignment.center, margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 100), color: Colors.black12, child: const UserList())),
      ),
    );
  }
}
