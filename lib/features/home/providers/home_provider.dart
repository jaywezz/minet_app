import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/home_repository.dart';

// Repository provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return MockHomeRepository();
});

// Home state
class HomeState {
  final bool isLoading;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Home notifier
class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;

  HomeNotifier(this._homeRepository) : super(const HomeState());

  // TODO: Add home-related state management methods
}

// Home provider
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return HomeNotifier(homeRepository);
});
