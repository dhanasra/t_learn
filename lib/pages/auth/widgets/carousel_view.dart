import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/utils/widgets/constants.dart';

class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (_,i){
        return CarouselPage(
            title1: carouselContent[i]['title1']!,
            title2: carouselContent[i]['title2']!,
            content1: carouselContent[i]['content1']!,
            content2: carouselContent[i]['content2']!,
            img: carouselContent[i]['img']!);
      },
    );
  }
}

class CarouselPage extends StatelessWidget {

  final String title1;
  final String title2;
  final String content1;
  final String content2;
  final String img;

  const CarouselPage({
    Key? key,
    required this.title1,
    required this.title2,
    required this.content1,
    required this.content2,
    required this.img
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title1, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30)).tr(),
          Text(title2, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30)).tr(),
          Utils.divider,
          Text(content1, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14)).tr(),
          Text(content2, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14)).tr(),
          Utils.divider,
          Expanded(child: Image.asset(img),)
        ],
      ),
    );
  }
}

