import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/pages/materials/model/notes.dart';
import 'package:t_learn/pages/materials/view_models/material_view_model.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../utils/utils.dart';

class MaterialsMainItem extends StatelessWidget {

  final Notes notes;

  const MaterialsMainItem({
    Key? key,
    required this.notes
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 4),
          ]
      ),
      child: InkWell(
        onTap: (){
          MaterialViewModel.selectedNotes = notes;
          const App().setNavigation(context, AppRoutes.notesList);
        },
        child: Column(
          children: [
            Expanded(child: CachedNetworkImage(imageUrl: notes.icon)),
            Utils.divider,
            Text(notes.name,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10
              ),),
          ],
        ),
      ),
    );
  }
}
