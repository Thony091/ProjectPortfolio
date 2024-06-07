import 'package:flutter/material.dart';

class CustomImageGallery extends StatelessWidget {

  final String image;
  
  const CustomImageGallery({super.key, required this.image});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: image.isEmpty
        ? ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover )
          ) 
        : 
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(image, fit: BoxFit.cover, ),
          )
    );
  }
}

