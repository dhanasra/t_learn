part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class GetTheme extends ThemeEvent{}

class UpdateTheme extends ThemeEvent{
  final String theme;
  UpdateTheme({required this.theme});
}

class GetLanguage extends ThemeEvent{}

class UpdateLanguage extends ThemeEvent{
  final String lang;
  UpdateLanguage({required this.lang});
}