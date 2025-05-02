import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppState {
  final bool isDarkMode;

  AppState({this.isDarkMode = false});

  AppState copyWith({bool? isDarkMode}) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void toggleTheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});