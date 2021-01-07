import 'package:cloud_firestore/cloud_firestore.dart';

class DatbaseService {

  final String uid;
  DatbaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brew');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // get brew stream
  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }

}