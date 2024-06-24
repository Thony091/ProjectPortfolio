import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child; // El contenido que quieres mostrar
  final double? opacity; // La opacidad de la imagen
  final String? image; // La imagen que quieres mostrar
  final Color? startColor;
  final Color? endColor;

  const BackgroundImageWidget({
    super.key, 
    required this.child, 
    this.opacity, 
    this.image,
    this.startColor,
    this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Imagen PNG como fondo
        SizedBox(
          width: double.infinity,
          height: size.height,
          child: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  startColor ?? Colors.black87,
                  endColor ?? const Color.fromARGB(255, 233, 227, 227),
                ],
              ),
            ),  
          ), // Color de fondo
        ),
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
