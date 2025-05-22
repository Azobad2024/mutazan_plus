part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class LightThemeState extends ThemeState{}

class DarkThemeState extends ThemeState{}