import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_structure/data/models/user_model.dart';
import 'package:flutter_structure/domain/use_cases/get_user_use_case.dart';

class HomeViewModel extends StateNotifier<AsyncValue<List<UserModel>>> {
  final GetUsersUseCase getUsersUseCase;

  HomeViewModel(this.getUsersUseCase) : super(const AsyncValue.loading()) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    state = const AsyncValue.loading();
    try {
      final users = await getUsersUseCase.execute();
      state = AsyncValue.data(users);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, AsyncValue<List<UserModel>>>((ref) {
  return HomeViewModel(ref.read(getUsersUseCaseProvider));
});
