import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../sidenavbar.dart';
import 'add_product.dart';

class ProdctsScreen extends StatefulWidget {
  const ProdctsScreen({Key? key}) : super(key: key);

  @override
  _ProdcytsScreenState createState() => _ProdcytsScreenState();
}

final productsSnapshots = FirebaseFirestore.instance;

class _ProdcytsScreenState extends State<ProdctsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
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
                                child: Text("Votre Produits"))),
                        ElevatedButton.icon(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              show(context);
                              /*  Authservices().signIn();*/
                            },
                            label: Text("Ajouter un produit"))
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: productsSnapshots
                          .collection('products')
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
                                      color: Colors.green.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Nom: ${snapshot.data!.docs[index].get('name')}"),
                                                Text(
                                                    "Prix : ${snapshot.data!.docs[index].get('price')}"),
                                                Text(
                                                    "Description : ${snapshot.data!.docs[index].get('description')}"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                                "${snapshot.data!.docs[index].get('url')}"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  show(BuildContext context) {
    String imageName = "cliquer pour choisir une image";
    String image = "";
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
                                "Ajouter un produit",
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
                                      controller: namController,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    ProductField(
                                      hintText: 'Description',
                                      controller: descController,
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
                                        controller: priceController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "Prix de Kg",
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
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.all(15),
                                        ),
                                        onPressed: () async {
                                          FilePickerResult result;
                                          result = (await FilePicker.platform
                                              .pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: [
                                                'png',
                                                'jpg'
                                              ]))!;
                                          if (result != null) {
                                            Uint8List? uploadFile =
                                                result.files.single.bytes;
                                            setState(() {
                                              imageName =
                                                  result.files.single.name;
                                            });
                                            Reference reference =
                                                FirebaseStorage.instance
                                                    .ref()
                                                    .child(imageName);
                                            final UploadTask uploadTask =
                                                reference.putData(uploadFile!);

                                            uploadTask.whenComplete(() async {
                                              var imageUpload = await uploadTask
                                                  .snapshot.ref
                                                  .getDownloadURL();
                                              var userCollection =
                                                  FirebaseFirestore.instance
                                                      .collection('products');

                                              await userCollection.doc().set({
                                                "name": namController.text,
                                                "description":
                                                    descController.text,
                                                "price": priceController.text,
                                                "url": imageUpload.toString(),
                                                "date": DateTime.now()
                                              });
                                            });
                                          }
                                        },
                                        child: Text("${imageName}")),
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
                                      if (imageName ==
                                              "cliquer pour choisir une image" ||
                                          imageName == "image oubligatoire") {
                                        setState(() {
                                          imageName = "image oubligatoire";
                                        });
                                      } else {
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
                                            "Produit ajouté avec succès",
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
