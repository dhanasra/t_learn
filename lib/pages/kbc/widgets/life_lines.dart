import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';

import 'common/border_button.dart';

class LifeLines extends StatelessWidget {
  final VoidCallback on5050Click;
  final VoidCallback onSkipClick;
  final VoidCallback onChangeClick;
  const LifeLines({
    Key? key,
    required this.on5050Click,
    required this.onChangeClick,
    required this.onSkipClick
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                  opacity: KBCViewModel.isLifeLine1Enable ? 1 : 0.5,
                  child: IcButton(
                    onPressed: KBCViewModel.isLifeLine1Enable ? onChangeClick : null,
                    icon: FontAwesomeIcons.repeat
                  ),
              ),
              Opacity(
                  opacity: KBCViewModel.isLifeLine2Enable ? 1 : 0.5,
                  child: IcButton(
                    onPressed: KBCViewModel.isLifeLine2Enable ? on5050Click : null,
                    icon: FontAwesomeIcons.circleHalfStroke
                  ),
              ),
              Opacity(
                  opacity: KBCViewModel.isLifeLine3Enable ? 1 : 0.5,
                  child: IcButton(
                    onPressed: KBCViewModel.isLifeLine3Enable ? onSkipClick : null,
                    icon: FontAwesomeIcons.lightbulb
                  )
              )
            ],
          ),
        );
  }
}