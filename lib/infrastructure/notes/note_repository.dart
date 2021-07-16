import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:tuto_domain_driven_design/domain/notes/i_note_repository.dart';
import 'package:tuto_domain_driven_design/domain/notes/note_failures.dart';
import 'package:tuto_domain_driven_design/domain/notes/note.dart';
import 'package:tuto_domain_driven_design/infrastructure/core/firestore_helpers.dart';
import 'package:tuto_domain_driven_design/infrastructure/notes/note_dtos.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: INoteRepository)
class NoteRepository implements INoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository(this._firestore);

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchAll() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy('serverTimestamp', descending: true)
        .snapshots()
        .map((snapshot) => right(
              snapshot.docs
                  .map(
                    (doc) => NoteDTO.fromFirestore(doc).toDomain(),
                  )
                  .toImmutableList(),
            ))
        .onErrorReturnWith();
    //users/{user ID}/notes/{note ID}
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFailure, Unit>> create(Note note) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
