import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/controller/home_controller.dart';
import 'home/home_screen.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {


  @override
  void initState() {
    context.read<HomeController>().fetchTotalDueAmount();
    context.read<HomeController>().fetchTotalDonor();
    context.read<HomeController>().fetchTotalAmount();
    context.read<HomeController>().fetchTotalSubmittedAmount();
    context.read<HomeController>().getAllExpenses();
    context.read<HomeController>().fetchTopUsers();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var controller = context.watch<HomeController>();

    return Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: HomeScreen(controller: controller, size: size),
          ),
        ));
  }
}

