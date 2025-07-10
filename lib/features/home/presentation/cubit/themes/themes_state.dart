part of 'themes_cubit.dart'; // This line links it to the cubit

sealed class ThemesState extends Equatable {
  const ThemesState();

  @override
  List<Object> get props => [];
}

// Initial state, not strictly needed but can be useful.
final class ThemesInitial extends ThemesState {}

// A state representing the light theme.
final class ThemesLight extends ThemesState {}

// A state representing the dark theme.
final class ThemesDark extends ThemesState {}
