import 'package:caducee/models/drug.dart';
import 'package:caducee/models/user.dart';
import 'package:caducee/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference drugCollection = FirebaseFirestore.instance.collection('drugs');
  final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('categories');

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
    return drugCollection.snapshots().map(_drugListFromSnapshot);
  }

  Future<List<AppDrugData>> getDrugs() async {
    final QuerySnapshot snapshot = await drugCollection.get();
    return _drugListFromSnapshot(snapshot);
  }

  Future<List<Category>> getCategories() async {
    final QuerySnapshot snapshot = await categoryCollection.get();
    return _categoryListFromSnapshot(snapshot);
  }

  List<AppDrugData> _drugListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppDrugData(
        name: (doc.data() as Map<String, dynamic>)['name'],
        molecule: (doc.data() as Map<String, dynamic>)['molecule'],
        description: (doc.data() as Map<String, dynamic>)['description'],
        form: (doc.data() as Map<String, dynamic>)['form'].cast<String>(),
        dosage: (doc.data() as Map<String, dynamic>)['dosage'].cast<String>(),
        category: (doc.data() as Map<String, dynamic>)['category'],
        recommendation: (doc.data() as Map<String, dynamic>)['recommendation'],
        usage: (doc.data() as Map<String, dynamic>)['usage'],
        favorite: (doc.data() as Map<String, dynamic>)['favorite'] == null ? [] : (doc.data() as Map<String, dynamic>)['favorite'].cast<String>(),
      );
    }).toList();
  }

  Future<void> saveDrug(String uid, String name, String molecule, String description,List<String> form, List<String> dosage, String category, String recommendation, String usage, List<String> favorite) async {
    return await drugCollection.doc(uid).set({
      'name': name,
      'molecule': molecule,
      'description': description,
      'form': form,
      'dosage': dosage,
      'category': category,
      'recommendation': recommendation,
      'usage': usage,
      'favorite': favorite,
    });
  }

  Future<void> addDrugToFavorites(AppDrugData drug) async {
  try {
    String normalizedName = removeDiacritics(drug.name);
    await drugCollection.doc(normalizedName.toLowerCase()).update({
      'favorite': FieldValue.arrayUnion([uid]),
    });
  } catch (e) {
    return;
  }
}

  Future<void> removeDrugFromFavorites(AppDrugData drug) async {
  try {
    String normalizedName = removeDiacritics(drug.name);
    await drugCollection.doc(normalizedName.toLowerCase()).update({
      'favorite': FieldValue.arrayRemove([uid]),
    });
  } catch (e) {
    return;
  }
}

  Stream<List<AppDrugData>> get favoriteDrugs {
    return drugCollection.where('favorite', arrayContains: uid).snapshots().map(_drugListFromSnapshot);
  }

  Stream<List<Category>> get categories {
    return _db.collection('categories').snapshots().map(_categoryListFromSnapshot);
  }

  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Category(
        name: (doc.data() as Map<String, dynamic>)['name'],
        description: (doc.data() as Map<String, dynamic>)['description'],
      );
    }).toList();
  }

  Future<void> saveCategory(String name, String description) async {
    return await _db.collection('categories').doc(name).set({
      'name': name,
      'description': description,
    });
  }

}
