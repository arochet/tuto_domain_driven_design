import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuto_domain_driven_design/domain/auth/i_auth_facade.dart';
import 'package:tuto_domain_driven_design/domain/core/errors.dart';

import '../../injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<IAuthFacade>().getSignedUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError);
    return FirebaseFirestore.instance
        .collection('user')
        .doc(user.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
