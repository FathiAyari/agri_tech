import 'package:flutter/material.dart';

class FeaturedTiles extends StatelessWidget {
  FeaturedTiles({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Image.network(
        "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__480.jpg",
        fit: BoxFit.cover,
      );
    });
  }
}
