import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plannusapk/models/user.dart';

class DatabaseMethods {

  final String uid;
  DatabaseMethods({this.uid});

  final CollectionReference users = Firestore.instance.collection("users");


  Future<void> updateUserData(String name, String handle) async {
    print(uid);
    return await users.document(uid).updateData({
      'name' : name,
      'handle' : handle,
    });
  }

  Future<void> updateSpecificUserData(String uid, String name, String handle) async {
    print(uid);
    return await users.document(uid).updateData({
      'name' : name,
      'handle' : handle,
    });
  }

  Future<Set<Set<String>>> getUserData() {
    return users.document(uid).get().then((value) => {
      if (value.exists) {
        value.data['handle']
      }
    });
  }

  Future<String> getSpecificUserData(String uid) async {
    String user = '';
    await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot ds) {
          user = ds["name"];
    });
    return user;
  }

//  void getSpecificUserData(String uid, String capture) async {
//    DocumentSnapshot snapshot =  await users.document(uid).get();
//    capture = snapshot.data['handle'];
//    print(capture);
//  }

//  Future<String> retrieveData(String uid) async {
//    DocumentSnapshot snap = await users.document(uid).get();
//    Map<String, String> map = snap.data;
//    String handle = map['name'];
//    return handle;
//  }
//
  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }


  // user data from snapshot
  Stream<QuerySnapshot> get userInfo {
    return users.snapshots();
  }

}