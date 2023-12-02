import 'package:docs_clone/features/home/domain/document.dart';
import 'package:docs_clone/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, AsyncValue<DocumentModel?>>((ref) {
  return HomeController(homeRepository: ref.read(homeRepositoryProvider));
});

class HomeController extends StateNotifier<AsyncValue<DocumentModel?>> {
  HomeController({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const AsyncValue.data(null));
  HomeRepository _homeRepository;
  Future createDoc() async {
    state = const AsyncLoading();
    try {
      final nmi = await _homeRepository.createDocument();
      state = AsyncData(nmi);
    } catch (e, tr) {
      state = AsyncError(e, tr);
    }
  }
}