// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
    final CacheHelper _cache;

  ThemeBloc(
    this._cache,
  ) : super(ThemeInitial()) {
    on<ChangeThemeEvent>((event, emit) async {
      if (event.isDark) {
        emit(DarkThemeState());
        // await _saveThemePreference(true);
      } else {
        emit(LightThemeState());
      }
      await _cache.saveData(key: 'isDarkMode', value: event.isDark);
    });
  }
}
