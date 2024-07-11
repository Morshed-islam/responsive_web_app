import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/controller/user_list_controller.dart';
import 'package:responsive_web_app/model/doner_model.dart';
import 'package:responsive_web_app/utils/app_utils.dart';

import '../../utils/device_screen_type.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late List<Doner> filteredContacts;

  @override
  void initState() {
    super.initState();
    context.read<UserListController>().getUsers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var controller = context.watch<UserListController>();
    filteredContacts = controller.donorList;
  }


  @override
  Widget build(BuildContext context) {
    var userController = context.watch<UserListController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) => userController.filterContacts(query),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'ডাতার নাম সার্চ করুন',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<UserListController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.donorList.isEmpty) {
                    return const Center(child: Text('No users found.'));
                  } else {
                    filteredContacts = controller.donorList;
                    return ListView.builder(
                      itemCount: filteredContacts.length,
                      itemBuilder: (context, index) {
                        final user = filteredContacts[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black26, width: 1),
                            // color: Colors.black12
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(
                                  width: (MediaQuery.of(context).size.width-150)/2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "নাম: ",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis)),
                                          ),
                                          Text(
                                            user.name,
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "গ্রাম: ",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400)),
                                          ),
                                          Text(
                                            user.village,
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "মোবাইল: ",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400)),
                                          ),
                                          Text(
                                            user.phone.isEmpty ? "নেই" : AppUtils.convertEngToBanglaNumber(user.phone),
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "মোট টাকা: ",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400,)),
                                          ),
                                          Text(
                                            "${AppUtils.convertEngToBanglaNumber(user.totalDonorAmount)} টাকা",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400)),
                                          ),
                                  
                                          const Spacer(),
                                          // IconButton(onPressed: ()=> showAddMoneyDialog(context,user), icon: const Icon(Icons.add_circle_outline_rounded),iconSize: 15,padding: EdgeInsets.zero,),
                                          InkWell(onTap: () {
                                           AppUtils.showAddMoneyDialog(context, user,controller);

                                          }, child: const Icon(Icons.add_circle_outline_rounded)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "মোট জমা: ",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400)),
                                          ),
                                          Text(
                                            "${AppUtils.convertEngToBanglaNumber(user.totalSubmittedAmount)} টাকা",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.green, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "বাকি টাকা: ",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 16, fontWeight: FontWeight.w600)),
                                          ),
                                          Text(
                                            "${AppUtils.convertEngToBanglaNumber(user.payableAmount)} টাকা",
                                            style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.red, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w600)),
                                          ),
                                          Spacer(),
                                          InkWell(onTap: () => AppUtils.showAddMoneyDialog(context, user,controller), child: const Icon(Icons.edit_note_sharp)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
