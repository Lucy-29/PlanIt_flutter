import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'themes_state.dart';

class ThemesCubit extends Cubit<ThemesState> {
  ThemesCubit() : super(ThemesLight());

  void toggleTheme(bool isDark) {
    if (isDark) {
      emit(ThemesDark());
    } else {
      emit(ThemesLight());
    }
  }
}
