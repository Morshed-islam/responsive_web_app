import 'package:flutter/material.dart';

import '../../utils/device_screen_type.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {

  List<Map<String, String>> contacts = [
    {
      'name': 'আব্দুল আজিজ',
      'village': 'ঝালখুর',
      'phone': '০১৭২২৩৩৫৫৫৫',
    },
    {
      'name': 'ফারাজ আলী',
      'village': 'ঝালখুর',
      'phone': '০১৭২৩৫০৫০৮০',
    },

    {
      'name': 'আব্দুল হাকিম ',
      'village': 'ঝালখুর',
      'phone': '০১৭২৩৫০৫০৮০',
    },

    {
      'name': 'আব্দুল মালেক ',
      'village': 'ঝালখুর',
      'phone': '০১৭২৩৫০৫০৮০',
    },

    {
      'name': 'আব্দুল খালেক ',
      'village': 'ঝালখুর',
      'phone': '০১৭২৩৫০৫০৮০',
    },

    {
      'name': 'আব্দুল ইব্রাহিম ',
      'village': 'ঝালখুর',
      'phone': '০১৭২৩৫০৫০৮০',
    },

    {
      'name': 'মাহফুজার ',
      'village': 'ঝালখুর',
      'phone': '০১৭২৩৫০৫০৮০',
    },
    // Add more contacts here
  ];

  late List<Map<String, String>> filteredContacts;




  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
  }

  void filterContacts(String query) {
    final results = contacts.where((contact) {
      final nameLower = contact['name']?.toLowerCase();
      final villageLower = contact['village']?.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower!.contains(searchLower) ||
          villageLower!.contains(searchLower);
    }).toList();

    setState(() {
      filteredContacts = results;
    });
  }


  void showContactDialog(BuildContext context, Map<String, String> contact) {
    final _formKey = GlobalKey<FormState>();
    final _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('টাকা জমা নিন'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('নাম: ${contact['name']}'),
                Text('গ্রাম: ${contact['village']}'),
                Text('মোবাইল নং: ${contact['phone']}'),
                const Text('বকেয়ার পরিমাণ: ২০,০০০',style: TextStyle(color: Colors.red),),

                const SizedBox(height: 16,),
                TextFormField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(labelText: 'জমার পরিমাণ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('কেটে দিন'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('জমা দিন'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Perform submit action
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: DeviceScreenType.isWeb(context) ||  DeviceScreenType.isTablet(context) ? const EdgeInsets.all(60.0) : const EdgeInsets.all(16.0) ,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) => filterContacts(query),
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
              child: ListView.builder(

                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = filteredContacts[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(contact['name'] ?? ""),
                    subtitle: Text('${contact['village']}\n${contact['phone']}'),
                    trailing: InkWell(
                        onTap: (){
                          showContactDialog(context,contact);
                        },
                        child: const Icon(Icons.add_card_rounded)),
                    isThreeLine: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
