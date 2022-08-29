import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/materials/model/notes_item.dart';
import 'package:t_learn/pages/materials/view_models/material_view_model.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';

class MaterialsListItem extends StatelessWidget {
  final NotesItem notesItem;
  const MaterialsListItem({
    Key? key,
    required this.notesItem
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
          MaterialViewModel.notesItem = notesItem;
          if(notesItem.isPrime){
            if(Globals.isPrime){
              const App().setNavigation(context, AppRoutes.notesViewer);
            }else{
              const App().setNavigation(context, AppRoutes.subscription);
            }
          }else{
            const App().setNavigation(context, AppRoutes.notesViewer);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(notesItem.subTag1,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, height: 1.5, color: primaryColor.withOpacity(0.8))),
                const Spacer(),

                if(notesItem.isPrime)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: Colors.deepOrange.withOpacity(0.4)),
                    color: Colors.orangeAccent.withOpacity(0.1)
                  ),
                  child: const Text("Prime",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10, height: 1.5, color: Colors.deepOrange)),
                ),

                Text("Pages : ${notesItem.pages} ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, height: 1.5, color: Theme.of(context).canvasColor)),
              ],
            ),
            Utils.dividerMedium,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CachedNetworkImage(imageUrl: notesItem.icon, width: 40,),
                ),
                Utils.verticalDividerMedium,
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notesItem.name,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, height: 1.5)),
                        if(notesItem.subTag2.isNotEmpty) Utils.dividerSmall,
                        if(notesItem.subTag2.isNotEmpty) Text(notesItem.subTag2,
                            style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 14))
                      ],
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
