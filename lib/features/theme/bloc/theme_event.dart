part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}
class ChangeThemeEvent extends ThemeEvent{
  bool isDark;
  ChangeThemeEvent({this.isDark = false});
}
