import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContactsScreen extends StatefulWidget {
  const MyContactsScreen({Key key}) : super(key: key);

  @override
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  Future<List<String>> checkforContacts() async {
    Trace contactaddTrace = FirebasePerformance.instance.newTrace('Contact-Add trace');
    await contactaddTrace.start();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contacts = prefs.getStringList("numbers") ?? [];
    print(contacts);
    await contactaddTrace.stop();
    return contacts;
  }

  updateNewContactList(List<String> contacts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("numbers", contacts);
    print(contacts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "SOS Contacts",
            style: TextStyle(fontFamily: 'metaplusmedium',
                fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Image.asset("assets/phone_red.png"),
            onPressed: () {},
          )),
      body: FutureBuilder(
          future: checkforContacts(),
          builder: (context, AsyncSnapshot<List<String>> snap) {
            if (snap.hasData && snap.data.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                        ),
                        Text('balayer'.tr),
                        Expanded(
                          child: Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snap.data.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage: AssetImage("assets/user.png"),
                              ),
                              title: Text(snap.data[index].split("***")[0] ??
                                  "aucunn".tr),
                              subtitle: Text(snap.data[index].split("***")[1] ??
                                  "aucunc".tr),
                            ),
                          ),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Effacer',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                print('Effacer');
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg:
                                          "${snap.data[index].split("***")[0] ?? "No Name"} supprimé!");
                                  snap.data.remove(snap.data[index]);

                                  updateNewContactList(snap.data);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("aucunct".tr),
              );
            }
          }),
    );
  }
}
