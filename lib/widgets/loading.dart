import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:t_learn/utils/widgets/constants.dart';

class Loading extends StatelessWidget {

  final String type;

  const Loading({
    Key? key,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.4),
      enabled: true,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: type != shimmer_1 ? 100 : 90,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),
              ),
              if(type != shimmer_1) Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: type == shimmer_3 ? 35: 20,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),
              ),
              if(type != shimmer_1) Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: type == shimmer_3 ? 15: 20,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),
              ),
              if(type == shimmer_3) Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 15,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),
              ),
              if(type == shimmer_3) Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 15,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),
              ),
              if(type == shimmer_3) Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 15,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),
              ),
            ],
        )
    );
  }
}
