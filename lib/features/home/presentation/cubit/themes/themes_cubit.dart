import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'themes_state.dart';

class ThemeCubit extends Cubit<ThemesState> {
  ThemeCubit() : super(ThemesLight());

  void toggleTheme(bool isDark) {
    if (isDark) {
      emit(ThemesDark());
    } else {
      emit(ThemesLight());
    }
  }
}
