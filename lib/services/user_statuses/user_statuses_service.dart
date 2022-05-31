import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/models/user_statuses_model.dart';

class UserStatusesService {
  final String uid = 'Tm6BJy2ZAuCNCKb5OTbf';

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_statuses');

  UserStatusesModel _dataFromSnapshots(DocumentSnapshot snapshot) {
    return UserStatusesModel(data: snapshot.get('data') ?? <String>[]);
  }

  Stream<UserStatusesModel>? get userStatuses {
    return uid != ''
        ? userCollection.doc(uid).snapshots().map(_dataFromSnapshots)
        : null;
  }
}
