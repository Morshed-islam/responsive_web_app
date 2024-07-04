import 'package:flutter/material.dart';
import 'package:responsive_web_app/screens/add_doner/add_doner.dart';
import '../../responsive/responsive_widget.dart';
import '../../utils/app_constant.dart';

class AddDonerScreen extends StatelessWidget {
  const AddDonerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('দাতার প্রোফাইল'),
        leading: InkWell(onTap:(){
          Navigator.popAndPushNamed(context, AppConstants.initialRoute);
        },child: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body:  ResponsiveWidget(
        mobile: const AddDonerProfile(),
        tablet: Container(
            alignment: Alignment.center,
            color: Colors.black12,
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 100),
                color: Colors.black12,
                child: const AddDonerProfile())),
        web: Container(
            alignment: Alignment.center,
            color: Colors.black12,
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 100),
                color: Colors.black12,
                child: const AddDonerProfile())),
      ),
    );
  }
}