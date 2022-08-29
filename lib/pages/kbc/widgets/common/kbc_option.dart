import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/kbc/bloc/cubit/options_cubit.dart';
import 'package:t_learn/pages/kbc/bloc/kbc_bloc/kbc_bloc.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';

import '../../../../utils/constants.dart';

class Option extends StatelessWidget {
  final String option;
  final String optionIndex;
  const Option({
    Key? key,
    required this.option,
    required this.optionIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocBuilder<OptionsCubit, String>(
          builder:(_,state){
            return Opacity(
                opacity: state.contains(optionIndex) ? 0.5 : 1,
                child: GestureDetector(
                  onTap: (){
                    context.read<KbcBloc>().add(StopTimer());
                    if(state.contains(optionIndex)) {
                      return;
                    }
                    KBCViewModel.selectedIndex=optionIndex;
                    if(KBCViewModel.cQuestion.answer==optionIndex){
                      context.read<OptionsCubit>().correct();
                      KBCViewModel.questionsIndex++;
                      Future.delayed(
                          const Duration(seconds: 1), ()=>const App().setNavigation(context, AppRoutes.kbcLevels)
                      );
                    }else{
                      context.read<OptionsCubit>().wrong();
                    }
                  },
                  child: HexagonContainer(
                      background: state=="correct" && KBCViewModel.selectedIndex==optionIndex
                          ? rgSuccess
                          : state=="wrong" && KBCViewModel.selectedIndex==optionIndex
                          ? rgFailure : rg,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
                      child: Text(option,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14))),
                )
    );}));
  }
}

class HexagonContainer extends StatelessWidget {
  final Gradient background;
  final Widget child;
  final EdgeInsets padding;
  const HexagonContainer({
    Key? key,
    required this.child,
    required this.background,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 50,
            height: 2,
            decoration: const BoxDecoration(
                gradient: lineGradientL)),

        Expanded(
          child: CustomPaint(
            painter: HexagonPainter(color: Colors.white),
            child: ClipPath(
                clipper: HexagonClipper1(),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(gradient: background),
                  padding: padding,
                  child: child,
                )
            )),
        ),

        Container(
            width: 50,
            height: 2,
            decoration: const BoxDecoration(
                gradient: lineGradientR))
      ],
    );
  }
}


class HexagonClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    double w = size.width;
    double h = size.height;

    return Path()
      ..moveTo(w*0.05, h)
      ..lineTo(w*0.95, h)
      ..lineTo(w, h*0.5)
      ..lineTo(w*0.95, 0)
      ..lineTo(w*0.05, 0)
      ..lineTo(0, h*0.5)
      ..lineTo(w*0.05, h);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HexagonPainter extends CustomPainter {
  Color color;
  HexagonPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    var path = Path();

    double w = size.width;
    double h = size.height;

    path = Path()
      ..moveTo(w*0.05, h)
      ..lineTo(w*0.95, h)
      ..lineTo(w, h*0.5)
      ..lineTo(w*0.95, 0)
      ..lineTo(w*0.05, 0)
      ..lineTo(0, h*0.5)
      ..lineTo(w*0.05, h);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
