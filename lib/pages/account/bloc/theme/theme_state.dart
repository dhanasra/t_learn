part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoading extends ThemeState {}

class ThemeUpdating extends ThemeState {}

class ThemeFetched extends ThemeState {
  final String theme;

  ThemeFetched({required this.theme});
}

class LanguageLoading extends ThemeState {}

class LanguageUpdating extends ThemeState {}

class LanguageFetched extends ThemeState {
  final String lang;

  LanguageFetched({required this.lang});
}