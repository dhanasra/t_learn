import 'package:flutter/material.dart';
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
        children: [
          Text(
            title1,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.black.withOpacity(0.7)
            ),
          ),
          Text(
            title2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.black.withOpacity(0.7)
            ),
          ),
          const Divider(color: Colors.transparent,),
          Text(
            content1,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.black.withOpacity(0.7)
            ),
          ),
          Text(
            content2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.black.withOpacity(0.7)
            ),
          ),
          const Divider(color: Colors.transparent,),
          Expanded(child: Image.asset(img),)
        ],
      ),
    );
  }
}

