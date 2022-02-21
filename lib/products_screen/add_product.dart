import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductField extends StatelessWidget {
  ProductField({
    required this.controller,
    required this.hintText,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            // validation function

            return ' cet champ est obligatoire ';
          } else
            return null;
        },
        controller: controller,
        decoration: InputDecoration(
            hintText: "$hintText",
            hintStyle: const TextStyle(
              color: Colors.blueAccent,
            ),
            fillColor: Colors.white10, // the color of the inside box field
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), //borderradius
            )),
      ),
    );
  }
}
