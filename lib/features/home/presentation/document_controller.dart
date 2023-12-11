import 'package:docs_clone/features/home/domain/document.dart';
import 'package:docs_clone/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final documentControllerProvider =
    StateNotifierProvider<DocumentController, AsyncValue<DocumentModel?>>(
        (ref) {
  return DocumentController(homeRepository: ref.watch(homeRepositoryProvider));
});
final documentProvider =
    FutureProvider.family<DocumentModel?, String>((ref, String id) async {
  return ref.read(documentControllerProvider.notifier).getDocumentById(id);
});

class DocumentController extends StateNotifier<AsyncValue<DocumentModel?>> {
  DocumentController({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const AsyncData(null));
  final HomeRepository _homeRepository;

  Future<DocumentModel?> getDocumentById(String id) async {
    try {
      final document = await _homeRepository.getDocumentById(id);

      return document;
    } catch (e, tr) {
      state = AsyncError(e, StackTrace.current);
      return null;
    }
  }
}
