import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:t_learn/pages/materials/bloc/materials_bloc.dart';
import 'package:t_learn/pages/materials/view_models/material_view_model.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/toaster.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../widgets/admob.dart';

final BannerAd myBanner = BannerAd(
  adUnitId: Admob.bannerId2,
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);

const AdSize adSize = AdSize(height: 50, width: 300);

class MaterialsViewerPage extends StatelessWidget {
  const MaterialsViewerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    myBanner.load();

    return Background(
        isBackPressed: true,
        actions: [
          BlocBuilder<MaterialsBloc,MaterialsState>(builder: (_,state){
            return IconButton(
              icon: Icon(state is MaterialSaved
                  ? Icons.favorite : Icons.favorite_border, size: 26),
              onPressed: ()=>BlocProvider.of<MaterialsBloc>(context).add(SaveMaterialsEvent()),
              splashRadius: 20,
            );
          }),
        ],
        child: BlocListener<MaterialsBloc, MaterialsState>(
          listener: (_,state){
            if(state is MaterialSaved){
              ScaffoldMessenger.of(context).showSnackBar(Toaster.snack(content: "Material Saved Successfully !"));
            }
          },
          child: MainBody(),
        ));
  }

}

class MainBody extends StatelessWidget {
  MainBody({Key? key}) : super(key: key);
  final AdWidget adWidget = AdWidget(ad: myBanner);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
          child: adWidget,
        ),
        Expanded(child: SfPdfViewer.network(
            MaterialViewModel.notesItem!.link,
            canShowPaginationDialog: false
        ))
      ],
    );
  }
}



