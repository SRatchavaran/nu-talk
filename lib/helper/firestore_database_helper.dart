import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/model/community/post_community_model.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';

class DatabaseMethods {
  var db = FirebaseFirestore.instance;

  String chatRoomTable = 'ChatRoom';
  String usersTable = 'Users';
  String bookingTimeTable = 'BookingTime';
  String noteTable = 'Note';
  String comunityTable = 'Community';

  String usernameDB = 'username';
  String datetimeDB = 'datetime';
  String emailDB = 'email';

  Future<bool> checkEmail(String value) async {
    bool isRepeat = false;
    await db.collection(usersTable).where(emailDB, isEqualTo: value).get().then((documentSnapshot) {
      if (documentSnapshot.docs.isNotEmpty) {
        isRepeat = true;
      }
    });
    return isRepeat;
  }

  Future<bool> checkName(String value) async {
    bool isRepeat = false;
    await db.collection(usersTable).where("name", isEqualTo: value).get().then((documentSnapshot) {
      if (documentSnapshot.docs.isNotEmpty) {
        isRepeat = true;
      }
    });
    return isRepeat;
  }

  uploadUserInfo(String name, UserModel userMap) {
    db.collection(usersTable).doc(name).set(userMap.toJson()).catchError((e) {
      log('ERR:$e');
    });
  }

  updateUserInfo(BuildContext context, {String? name, int? image, int? theme, int? gender, String? age}) {
    MainProvider mainProvider = context.provide<MainProvider>(listen: false);
    var user = mainProvider.user;
    if (user != null) {
      UserModel model = UserModel(
        name: name ?? user.name,
        image: image ?? user.image,
        theme: theme ?? user.theme,
        age: age ?? user.age,
        genderStr: gender ?? user.genderStr,
        email: user.email,
        type: user.type,
        userId: user.userId,
        uid: user.uid,
      );
      mainProvider.user = model;
      db.collection(usersTable).doc(user.email).update(model.toJson()).catchError((e) {
        log('ERR:$e');
      });
    } else {
      context.showToast(msg: 'common.err.system_err');
    }
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    db.collection(chatRoomTable).doc(chatRoomId).set(chatRoomMap).catchError((e) {
      log(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection(chatRoomTable)
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .then((DocumentReference doc) => log('DocumentSnapshot added with ID: ${doc.id}'));
  }

  addBookingTime(String name, bookingMap) {
    db.collection(bookingTimeTable).doc(name).set(bookingMap).catchError((e) {
      log(e.toString());
    });
  }

  addCommentPost(String postRoomId, commentMap) {
    FirebaseFirestore.instance
        .collection(comunityTable)
        .doc(postRoomId)
        .collection("comments")
        .add(commentMap)
        .then((DocumentReference doc) => log('DocumentSnapshot added with ID: ${doc.id}'));
  }

  addPostCommunity({required String postRoomId, required PostCommunityModel postMap}) {
    db.collection(comunityTable).doc(postRoomId).set(postMap.toJson()).catchError((e) {
      log(e.toString());
    });
  }

  addNote(String chatRoomId, postMap) {
    db.collection(noteTable).doc(chatRoomId).set(postMap).catchError((e) {
      log(e.toString());
    });
  }

  updateCountComment(String postRoomId, int countComment) async {
    return db.collection(comunityTable).doc(postRoomId).update({
      'countComment': countComment,
    });
  }

  updateStatusChat(String chatRoomId, String statusChat) async {
    return db.collection(chatRoomTable).doc(chatRoomId).update({
      'status': statusChat,
    });
  }

  updateDegreeBegin(String id, int degree) async {
    return db.collection(bookingTimeTable).doc(id).update({
      'degreeBegin': degree,
    });
  }

  updateDegreeEnd(String id, int degree) async {
    return db.collection(bookingTimeTable).doc(id).update({
      'degreeEnd': degree,
    });
  }

  updateRateApp(String myEmail, int rate) async {
    return db.collection(usersTable).doc(myEmail).update({
      'rateApp': rate,
    });
  }

  updateCheckChat(String chatRoomId, String check) async {
    return db.collection(chatRoomTable).doc(chatRoomId).update({
      'check': check,
    });
  }

  updateCaseChat(String chatRoomId, String active) async {
    return db.collection(chatRoomTable).doc(chatRoomId).update({
      'case': active,
    });
  }

  updateBookingNextChat(String chatRoomId, String booking) async {
    return db.collection(chatRoomTable).doc(chatRoomId).update({
      'booking': booking,
    });
  }

  updateTimeChat(String chatRoomId, Timestamp timestamp) async {
    return db.collection(chatRoomTable).doc(chatRoomId).update({
      datetimeDB: timestamp,
    });
  }

  updateStatus(String nameH, String status) async {
    return db.collection(bookingTimeTable).doc(nameH).update({
      'status': status,
    });
  }

  updateImageAdvisor(String nameH, String image) async {
    return db.collection(bookingTimeTable).doc(nameH).update({
      'imageAdvisor': image,
    });
  }

  updateSelect(String name, int i, String choice) async {
    return db.collection(usersTable).doc(name).update({
      'select$i': choice,
    });
  }

  updateThemeColor(String name, int theme) async {
    return db.collection(usersTable).doc(name).update({
      'theme': theme,
    });
  }

  updateProfile(String name, String image) async {
    return db.collection(usersTable).doc(name).update({
      'image': image,
    });
  }

  updateUsername(String name, String username) async {
    return db.collection(usersTable).doc(name).update({
      usernameDB: username,
    });
  }

  updateCreateChatBooking(String idBooking, bool createChat) async {
    return db.collection(bookingTimeTable).doc(idBooking).update({
      'createChat': createChat,
    });
  }

  updateCreateChatConvesation(String id, bool createChat) async {
    return db.collection(chatRoomTable).doc(id).update({
      'createChat': createChat,
    });
  }

  updateIsRead2(String myname, String replyName, String chatId) async {
    return db.collection(chatRoomTable).doc(replyName).collection(myname).doc(chatId).update({
      'read': 'อ่านแล้ว',
    });
  }

  updateIsRead1(String myname, String replyName, String chatId) async {
    return db.collection(chatRoomTable).doc(myname).collection(replyName).doc(chatId).update({
      'read': 'อ่านแล้ว',
    });
  }

  updatefcmToken(String email, String fcmToken) async {
    return db.collection(usersTable).doc(email).update({
      'fcmToken': fcmToken,
    });
  }

  getProfileIncommunity(String name) async {
    return db.collection(comunityTable).where("postBy", isEqualTo: name).snapshots();
  }

  createUserInfo(String name, String username, String gender, String age, String image, List<String> indexList) async {
    return FirebaseFirestore.instance
        .collection(usersTable)
        .doc(name)
        .update({usernameDB: username, 'gender': gender, 'age': age, 'image': image, 'searchIndex': indexList});
  }

  clearPost(String postId) {
    return db.collection(comunityTable).doc(postId).delete();
  }

  getBookingTime(String name) async {
    return FirebaseFirestore.instance
        .collection(bookingTimeTable)
        .where("name", isEqualTo: name)
        .orderBy(datetimeDB, descending: true)
        .snapshots();
  }

  getNote(String name) async {
    return FirebaseFirestore.instance
        .collection(noteTable)
        .where("writeBy", isEqualTo: name)
        .orderBy(datetimeDB, descending: true)
        .snapshots();
  }

  getBookingTimeAdvisor(String name) async {
    return FirebaseFirestore.instance
        .collection(bookingTimeTable)
        .where("advisor", isEqualTo: name)
        .orderBy(datetimeDB, descending: true)
        .snapshots();
  }

  getImageProfile(String name) async {
    return db.collection(usersTable).where("email", isEqualTo: name).snapshots();
  }

  getImageProfileSetting(String name) async {
    return db.collection(usersTable).where(usernameDB, isEqualTo: name).snapshots();
  }

  getCountComment(String postRoomId) async {
    return db.collection(comunityTable).doc(postRoomId).collection("countComments").snapshots();
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection(chatRoomTable)
        .doc(chatRoomId)
        .collection("chats")
        .orderBy(datetimeDB, descending: true)
        .snapshots();
  }

  getChatRoomId(String chatRoomId) async {
    return db.collection(chatRoomTable).doc(chatRoomId).snapshots();
  }

  getCommentPost(String postRoomId) async {
    return FirebaseFirestore.instance
        .collection(comunityTable)
        .doc(postRoomId)
        .collection("comments")
        .orderBy(datetimeDB, descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection(chatRoomTable)
        .where(usersTable, arrayContains: userName)
        .orderBy(datetimeDB, descending: true)
        .snapshots();
  }

  getCommunityPrivate(String myName) async {
    return db.collection(comunityTable).where("postBy", arrayContains: myName).snapshots();
  }

  getPost() async {
    return FirebaseFirestore.instance
        .collection(comunityTable)
        .where("postBy")
        .orderBy(datetimeDB, descending: true)
        .snapshots();
  }

  getUsers() async {
    return FirebaseFirestore.instance
        .collection(usersTable)
        .where(usernameDB)
        .orderBy(usernameDB, descending: false)
        .snapshots();
  }

  Future<UserModel?> getUserByEmail(String email) async {
    Completer<UserModel?> c = Completer<UserModel?>();
    db.collection(usersTable).where(emailDB, isEqualTo: email).snapshots().listen(
      (event) {
        UserModel? user;
        if (event.docs.isNotEmpty) {
          user = UserModel.fromJson(event.docs.first.data());
        }
        c.complete(user);
      },
      onError: (error) => log("Listen failed: $error"),
    );
    return c.future;
  }

  getBookingTimeAll() async {
    return FirebaseFirestore.instance
        .collection(bookingTimeTable)
        .where("name")
        .orderBy(datetimeDB, descending: true)
        .snapshots();
  }

  getPostInside(String postRoomID) async {
    return db.collection(comunityTable).where("postRoomId", isEqualTo: postRoomID).snapshots();
  }

  getUserByUsername(String username) async {
    return db.collection(usersTable).where(usernameDB, isEqualTo: username).get();
  }

  getUserByUserEmail(String userEmail) async {
    return db.collection(usersTable).where(emailDB, isEqualTo: userEmail).get();
  }

//   Future<int> getUnreadMSGCount([String peerUserID, String myname, String replyName]) async {
//     try {
//       int unReadMSGCount = 0;
//       String targetID = '';
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       peerUserID == null ? targetID = (prefs.get('userId') ?? 'NoId') : targetID = peerUserID;
// //      if (targetID != 'NoId') {
//       final QuerySnapshot chatListResult =
//           db.collection('ChatRoom').doc(myname).collection(replyName).getdocs();
//       final List<docSnapshot> chatListdocs = chatListResult.docs;
//       for (var data in chatListdocs) {
//          QuerySnapshot unReadMSGdoc =  await FirebaseFirestore.instance
//             .collection('Chatroom')
//             .doc(myname)
//             .collection(replyName)
//             .where('replyName', isEqualTo: myname)
//             .where('read', isEqualTo: '')
//             .get();

//         final List<docSnapshot> unReadMSGdocs = unReadMSGdoc.docs;
//         unReadMSGCount = unReadMSGCount + unReadMSGdocs.length;
//       }
//       log('unread MSG count is $unReadMSGCount');
// //      }
//       return unReadMSGCount;
//     } catch (e) {
//       log(e.message);
//     }
//   }
}
