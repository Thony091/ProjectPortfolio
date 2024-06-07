import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child; // El contenido que quieres mostrar
  final double? opacity; // La opacidad de la imagen
  final String? image; // La imagen que quieres mostrar

  const BackgroundImageWidget({
    super.key, 
    required this.child, 
    this.opacity, 
    this.image,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        // Imagen PNG como fondo
        Center(
          child: Opacity(
            opacity: opacity!,
            child: Image.asset(
              'assets/icons/AR_2.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        // Contenido de la vista
        child,
      ],
    );
  }
}
