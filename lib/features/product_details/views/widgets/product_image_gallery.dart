import 'package:flutter/material.dart';

class ProductImageGallery extends StatelessWidget {
  final List<String> imageUrls;

  const ProductImageGallery({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const AspectRatio(
        aspectRatio: 1,
        child: ColoredBox(
          color: Color(0xFFEAEAEA),
          child: Icon(Icons.image_outlined),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: 1,
      child: PageView(
        children: imageUrls
            .map((url) => Image.network(url, fit: BoxFit.cover))
            .toList(),
      ),
    );
  }
}
