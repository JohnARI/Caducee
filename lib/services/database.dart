import 'package:caducee/models/drug.dart';
import 'package:caducee/models/user.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUser(String name, String email) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
  return AppUserData(
    uid: uid,
    name: (snapshot.data() as Map<String, dynamic>)['name'],
    email: (snapshot.data() as Map<String, dynamic>)['email'],
  );
}


  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return AppUserData(
      uid: uid,
      name: (doc.data() as Map<String, dynamic>)['name'],
      email: (doc.data() as Map<String, dynamic>)['email'],
    );
  }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<List<AppDrugData>> get drugs {
    return _db.collection('drugs').snapshots().map(_drugListFromSnapshot);
  }

  List<AppDrugData> _drugListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppDrugData(
        name: (doc.data() as Map<String, dynamic>)['name'],
        shortDesc: (doc.data() as Map<String, dynamic>)['shortDesc'],
        longDesc: (doc.data() as Map<String, dynamic>)['longDesc'],
        molecularFormula: (doc.data() as Map<String, dynamic>)['molecularFormula'],
        utility: (doc.data() as Map<String, dynamic>)['utility'],
        timing: (doc.data() as Map<String, dynamic>)['timing'],
      );
    }).toList();
  }
}
