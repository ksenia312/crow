import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/models/user_statuses_model.dart';

class UserStatusesService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_statuses');

  UserStatusesModel _dataFromSnapshots(DocumentSnapshot snapshot) {
    return UserStatusesModel(statuses: snapshot.get('statuses') ?? <String>[]);
  }

  Stream<UserStatusesModel>? get userStatuses {
    return userCollection.doc('data').snapshots().map(_dataFromSnapshots);
  }
}
