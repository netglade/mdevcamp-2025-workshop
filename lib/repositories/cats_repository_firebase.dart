import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:netglade_utils/netglade_utils.dart';

class CatsRepositoryFirebase implements CatsRepository {
  late final Stream<Result<List<Cat>, RepositoryError>> catsStream;
  late final Stream<Result<List<CatBreed>, RepositoryError>> breedsStream;

  late final FirebaseFirestore _db;
  bool _isLoaded = false;

  void _init() {
    if (_isLoaded) {
      return;
    }
    _isLoaded = true;

    _db = FirebaseFirestore.instance;

    final catsTransformer = StreamTransformer<
        QuerySnapshot<Map<String, dynamic>>,
        Result<List<Cat>, RepositoryError>>.fromHandlers(
      handleData: (snapshot, sink) {
        final cats =
            snapshot.docs.map((doc) => Cat.fromJson(doc.data())).toList();
        sink.add(Result.success(cats));
      },
      handleError: (error, stackTrace, sink) {
        sink.add(
          Result.error(
            RepositoryError(exception: error, stackTrace: stackTrace),
          ),
        );
      },
    );
    catsStream = _db.collection('cats').snapshots().transform(catsTransformer);

    final breedsTransformer = StreamTransformer<
        QuerySnapshot<Map<String, dynamic>>,
        Result<List<CatBreed>, RepositoryError>>.fromHandlers(
      handleData: (snapshot, sink) {
        final breeds =
            snapshot.docs.map((doc) => CatBreed.fromJson(doc.data())).toList();
        sink.add(Result.success(breeds));
      },
      handleError: (error, stackTrace, sink) {
        sink.add(
          Result.error(
            RepositoryError(exception: error, stackTrace: stackTrace),
          ),
        );
      },
    );
    breedsStream =
        _db.collection('breeds').snapshots().transform(breedsTransformer);
  }

  @override
  Future<Result<Cat, RepositoryError>> adoptCat({
    required String catId,
    required String userId,
  }) async {
    try {
      final catsOrError = await _db.collection('cats').doc(catId).get();

      if (!catsOrError.exists) {
        return Future.value(
          Result.error(RepositoryError(exception: 'Cat not found')),
        );
      }

      final cat = Cat.fromJson(catsOrError.data()!);

      final adoptedCat = cat.copyWith(
        adoptedBy: userId,
        isAdopted: true,
      );

      await _db.collection('cats').doc(adoptedCat.id).update(adoptedCat.toJson());

      return Future.value(Result.success(adoptedCat));
      // ignore: avoid_catches_without_on_clauses, gonna catch em all
    } catch (e, s) {
      return Future.value(
        Result.error(RepositoryError(exception: e, stackTrace: s)),
      );
    }
  }

  @override
  Future<Result<List<CatBreed>, RepositoryError>> getBreeds() async {
    _init();

    try {
      return const Result.success([]);
      // ignore: avoid_catches_without_on_clauses, gonna catch em all
    } catch (e, s) {
      return Result.error(RepositoryError(exception: e, stackTrace: s));
    }
  }

  @override
  Stream<Result<List<CatBreed>, RepositoryError>> getBreedsStream() async* {
    _init();

    yield* breedsStream;
  }

  @override
  Future<Result<List<Cat>, RepositoryError>> getCats({
    CatFilter? filter,
  }) async {
    _init();

    try {
      return const Result.success([]);
      // ignore: avoid_catches_without_on_clauses, gonna catch em all
    } catch (e, s) {
      return Result.error(RepositoryError(exception: e, stackTrace: s));
    }
  }

  @override
  Stream<Result<List<Cat>, RepositoryError>> getCatsStream({
    CatFilter? filter,
  }) async* {
    _init();

    yield* catsStream.map(
      (result) => result.map(
        success: (cats) => Success(
          cats.success.where((cat) => filter?.apply(cat: cat) ?? true).toList(),
        ),
        error: (error) => error,
      ),
    );
  }
}
