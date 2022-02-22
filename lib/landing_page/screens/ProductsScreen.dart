import 'package:agritech/dashboard/products_screen/add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

final productsSnapshots = FirebaseFirestore.instance;

class ProductsClients extends StatefulWidget {
  const ProductsClients({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsClients> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNnamController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Text(
          "Bienvenue chez Agri Tech ",
          style: TextStyle(fontSize: 30),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: productsSnapshots
                .collection('products')
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: GridTile(
                        footer: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Nom: ${snapshot.data!.docs[index].get('name')}"),
                              Text(
                                  "Prix : ${snapshot.data!.docs[index].get('price')}"),
                              Text(
                                  "Description : ${snapshot.data!.docs[index].get('description')}"),
                              ElevatedButton(
                                  onPressed: () {
                                    show(
                                        context,
                                        snapshot
                                            .data!.docs[index].reference.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.all(15),
                                  ),
                                  child: Text("Passer une commande"))
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "${snapshot.data!.docs[index].get('url')}",
                            ),
                          ),
                        ), //just for testing, will fill with image later
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    )));
  }

  show(BuildContext context, String product_id) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffe3eaef),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Container(
                          height: size.height * 0.6,
                          width: size.width * 0.4,
                          child: Column(
                            children: [
                              Text(
                                "Ajouter une commande ",
                                style: TextStyle(
                                    fontFamily: "Tajawal", fontSize: 20),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    ProductField(
                                      hintText: 'Nom',
                                      controller: nameController,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    ProductField(
                                      hintText: 'Prénom',
                                      controller: lastNnamController,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    ProductField(
                                      hintText: 'Adresse',
                                      controller: adressController,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Container(
                                      height: size.height * 0.1,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            // validation function

                                            return ' cet champ est obligatoire ';
                                          } else
                                            return null;
                                        },
                                        controller: gsmController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "GSM ",
                                            hintStyle: const TextStyle(
                                              color: Colors.blueAccent,
                                            ),
                                            fillColor: Colors
                                                .white10, // the color of the inside box field
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), //borderradius
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.all(15),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var userCollection = FirebaseFirestore
                                          .instance
                                          .collection('commands');

                                      await userCollection.doc().set({
                                        "adress": adressController.text,
                                        "date": DateTime.now(),
                                        "gsm": gsmController.text,
                                        "lastname": lastNnamController.text,
                                        "name": nameController.text,
                                        "product_id": product_id,
                                        "state": false
                                      });
                                      Get.rawSnackbar(
                                        borderRadius: 20,
                                        backgroundColor:
                                            Colors.green.withOpacity(0.9),
                                        titleText: Text(
                                          "Agri Tech",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                        messageText: Text(
                                          "Command ajouté avec succès",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                        icon: Icon(Icons.done_all,
                                            color: Colors.white),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text("Confirmer")),
                            ],
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      )),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          });
        });
  }
}
