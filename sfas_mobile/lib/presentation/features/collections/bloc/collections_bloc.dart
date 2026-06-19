import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/collection_repository.dart';
import 'collections_event.dart';
import 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final CollectionRepository _collectionRepository;

  CollectionsBloc({required CollectionRepository collectionRepository})
      : _collectionRepository = collectionRepository,
        super(const CollectionsState.initial()) {
    on<CollectionsEvent>((event, emit) async {
      await event.map(
        loadCollections: (_) => _onLoadCollections(emit),
        createCollection: (e) => _onCreateCollection(e.collectionData, emit),
      );
    });
  }

  Future<void> _onLoadCollections(Emitter<CollectionsState> emit) async {
    emit(const CollectionsState.loading());
    try {
      final collections = await _collectionRepository.getCollections();
      emit(CollectionsState.loaded(collections));
    } catch (e) {
      if (e.toString().contains('Access is denied') || e.toString().contains('403')) {
        emit(const CollectionsState.error('Access Denied: You do not have permission to view collections.'));
      } else {
        emit(CollectionsState.error(e.toString()));
      }
    }
  }

  Future<void> _onCreateCollection(Map<String, dynamic> collectionData, Emitter<CollectionsState> emit) async {
    try {
      await _collectionRepository.createCollection(collectionData);
      add(const CollectionsEvent.loadCollections());
    } catch (e) {
      emit(CollectionsState.error(e.toString()));
    }
  }
}
