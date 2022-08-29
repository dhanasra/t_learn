import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/account/view_models/account_view_model.dart';


class GenderContainer extends StatelessWidget {
  final String gender;
  const GenderContainer({
    Key? key,
    required this.gender
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AccountViewModel viewModel = AccountViewModel();

    return InkWell(
      onTap: (){
        print(1);
        viewModel.isMale.value = gender;

      },
      child: ValueListenableBuilder(
        valueListenable: viewModel.isMale,
        builder: (_,__,___){
          print(viewModel.isMale.value);
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
                  color: viewModel.isMale.value==gender ? Colors.teal.withOpacity(0.2) : Colors.transparent
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    gender=="Male" ? FontAwesomeIcons.person : FontAwesomeIcons.personDress ,
                    color: Colors.black.withOpacity(0.5),),
                  SizedBox(
                    width: 60,
                    child: Center(
                      child: Text( gender,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                      ),
                    ),
                  )
                ],
              )
          );
        },
      ),
    );
  }
}
