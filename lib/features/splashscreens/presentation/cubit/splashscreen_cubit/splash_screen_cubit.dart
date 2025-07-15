import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  static const String _hasSeenSplashKey = 'has_seen_splash';

  SplashScreenCubit() : super(SplashScreenInitial()) {
    checkIfFirstTime();
  }

  Future<void> checkIfFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = prefs.getBool(_hasSeenSplashKey) ?? false;

    if (hasSeen) {
      emit(SplashScreenComplete());
    } else {
      emit(SplashScreenInProgress());
    }
  }

  Future<void> markSplashScreensAsComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenSplashKey, true);
    emit(SplashScreenComplete());
  }
}
