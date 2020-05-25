import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plannusapk/models/schedule_time.dart';
import 'package:plannusapk/models/timetable.dart';
import 'package:plannusapk/models/user.dart';
import 'package:plannusapk/models/activity.dart';

class DatabaseMethods {

  final String uid;
  DatabaseMethods({this.uid});

  final CollectionReference users = Firestore.instance.collection("users");

  Future<void> createNewUserData(String email, String name, String handle) async {
    print(uid);
    return await users.document(uid).updateData({
      'email' : email,
      'name' : name,
      'handle' : handle,
      'timetable' : TimeTable()
    });
  }

//  Future<void> updateUserData(String email, String name, String handle) async { //duplicate code
//    print(uid);
//    return await users.document(uid).updateData({
//      'email' : email,
//      'name' : name,
//      'handle' : handle,
//    });
//  }

  Future<void> addUserData(String email, String name, String handle) async {
    print(uid);
    return await users.document(uid).setData({
      'email' : email,
      'name' : name,
      'handle' : handle,
    });
  }

  Future<void> updateSpecificUserData(String uid, String name, String handle) async {
    print(uid + " here");
    print(handle.isEmpty);
    return await users.document(uid).updateData({
      'name' : name,
      'handle' : handle,
    });
  }


  Future<String> getSpecificUserData(String uid) async {
    String user;
    await users.document(uid).get().then((value) => {
      user = value['handle']
    });
    //print(user);
    return user;
  }

  Future<void> updateSchedule(String day, String bName, ScheduleTime bStart, ScheduleTime bEnd, bool isImportant) async {
    return await users.document(uid).get().then((value) => {
      value['timetable'].alter(day, bName, bStart, bEnd, isImportant)
    });
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }

  Future<QuerySnapshot> getUserByHandle(String handle) async {
    return await users.where("handle", isEqualTo: handle).getDocuments();
  }
  Future<QuerySnapshot> getUserByName(String name) async {
    return await users.where("name", isEqualTo: name).getDocuments();
  }

  Future<QuerySnapshot> getUserByUserEmail(String email) async {
    return await users.where("email", isEqualTo: email).getDocuments();
  }

  Future<DocumentSnapshot> getHandleByEmail(String uid) async {
    return await users.document(uid).get();
  }

  // user data from snapshot
  Stream<QuerySnapshot> get userInfo {
    return users.snapshots();
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((onError){
      print(onError.toString());
    });
  }

}