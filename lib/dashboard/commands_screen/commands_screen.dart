import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../sidenavbar.dart';

final productsSnapshots = FirebaseFirestore.instance;

class CommandsScreen extends StatefulWidget {
  const CommandsScreen({Key? key}) : super(key: key);

  @override
  _ProdcytsScreenState createState() => _ProdcytsScreenState();
}

class _ProdcytsScreenState extends State<CommandsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Row(
            children: <Widget>[
              Container(
                child: SideNavBar(),
              ),
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text("Votre Commandes"))),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: productsSnapshots
                              .collection('commands')
                              .orderBy('date', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.01,
                                        right: size.width * 0.1,
                                        left: size.width * 0.03),
                                    child: Container(
                                      height: size.height * 0.2,
                                      decoration: BoxDecoration(
                                          color: snapshot.data!.docs[index]
                                                      .get('state') ==
                                                  true
                                              ? Colors.green.withOpacity(0.5)
                                              : Colors.red.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Nom et Prénom: ${snapshot.data!.docs[index].get('name')} ${snapshot.data!.docs[index].get('lastname')}"),
                                                    Container(
                                                      child: StreamBuilder<
                                                              DocumentSnapshot>(
                                                          stream: productsSnapshots
                                                              .collection(
                                                                  'products')
                                                              .doc(
                                                                  "${snapshot.data!.docs[index].get('product_id')}")
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            var userDocument =
                                                                snapshot.data;
                                                            if (snapshot
                                                                .hasData) {
                                                              return Text(
                                                                  "Produit : ${userDocument!.get('name')}");
                                                            }
                                                            return CircularProgressIndicator();
                                                          }),
                                                    ),
                                                    Text(
                                                        "Adresse : ${snapshot.data!.docs[index].get('adress')} "),
                                                    Text(
                                                        "Numéro portable : ${snapshot.data!.docs[index].get('gsm')} "),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            snapshot.data!.docs[index]
                                                        .get('state') ==
                                                    false
                                                ? ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.green,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      padding:
                                                          EdgeInsets.all(15),
                                                    ),
                                                    onPressed: () {
                                                      snapshot.data!.docs[index]
                                                          .reference
                                                          .update(
                                                              {'state': true});
                                                      Get.rawSnackbar(
                                                        borderRadius: 20,
                                                        backgroundColor: Colors
                                                            .green
                                                            .withOpacity(0.9),
                                                        titleText: Text(
                                                          "Agri Tech",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        messageText: Text(
                                                          "Command terminé avec succès",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        icon: Icon(
                                                            Icons.done_all,
                                                            color:
                                                                Colors.white),
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                      );
                                                    },
                                                    child: Text(
                                                        "Marquer comme terminé"))
                                                : Row(
                                                    children: [
                                                      Icon(
                                                        Icons.done_all,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Terminé",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                    ],
                  )),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
