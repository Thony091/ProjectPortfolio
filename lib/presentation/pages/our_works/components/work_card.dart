import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../shared/shared.dart';

class WorkCard extends StatelessWidget {

  final Works work;
  final Function()? onTapdEdit;
  final Function()? onTapDelete;

  const WorkCard({
    super.key,
    required this.work,
    this.onTapdEdit,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ImageViewer( 
          image: work.image,
          title: work.name,
          description: work.description,
          onTapdEdit: onTapdEdit,
          onTapDelete: onTapDelete,
        ),
      ],
    );
  }
}


class _ImageViewer extends StatelessWidget {

  final String image;
  final String title;
  final String description;
  final Function()? onTapdEdit;
  final Function()? onTapDelete;

  const _ImageViewer({
    required this.image,
    this.title = '', 
    this.description = '',
    this.onTapdEdit,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    if ( image.isEmpty ) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(width: size.width * 0.93,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 238, 236, 185),
                blurRadius: 5,
                offset: Offset(0, 3)
              ),
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            
                Image.asset('assets/images/no-image.jpg', 
                  fit: BoxFit.cover,
                  height: 110,
                  width: size.width * 0.23,
                ),
                Container(
                  width: size.width * 0.50,
                  padding: const EdgeInsets.only( left: 5, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox( height: 10 ),
                      Text(
                        maxLines: 3,
                        description,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox( height: 10 ),

                    ],
                  ),
                ),

                Row( children:
                  [

                    const SizedBox( width: 10 ),
                    CustomIconButton(
                      onTap: onTapdEdit ?? () {}, 
                      icon: Icons.edit,
                      size: 22,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox( width: 10 ),
                    CustomIconButton(
                      onTap: onTapDelete ?? () {}, 
                      icon: Icons.delete,
                      size: 22,
                      color: Colors.redAccent,
                    ),

                  ]
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 250,
        width: size.width * 0.93,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        image: NetworkImage( image ),
        placeholder: const AssetImage('assets/loaders/loader2.gif'),
      ),
    );

  }
}