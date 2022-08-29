
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/auth/model/UserData.dart';
import 'package:t_learn/utils/fb.dart';
import 'package:t_learn/utils/globals.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  final BuildContext context;

  ThemeBloc({required this.context}) : super(ThemeFetched(theme: "lightTheme")) {
    on<GetTheme>(onGetTheme);
    on<UpdateTheme>(onUpdateTheme);
    on<UpdateLanguage>(onUpdateLanguage);
  }

  void onGetTheme(GetTheme event, Emitter emit)async{
    emit(ThemeLoading());
    UserData? data = await DB.getUserData();
    Globals.theme = data!.appTheme;
    emit(ThemeFetched(theme: data.appTheme));
  }

  void onUpdateTheme(UpdateTheme event, Emitter emit)async{
    emit(ThemeFetched(theme: event.theme));

    Map<String, Object?> updateData = {};
    updateData["appTheme"] = event.theme;
    Globals.theme = event.theme;
    await DB.updateProfile(updateData);
  }

  void onUpdateLanguage(UpdateLanguage event, Emitter emit)async{
    Map<String, Object?> updateData = {};
    updateData["appLang"] = event.lang;
    Globals.language = event.lang;
    await DB.updateProfile(updateData);
  }
}
