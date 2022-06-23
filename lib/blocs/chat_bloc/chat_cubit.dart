import 'dart:io';

import 'package:chat_try_3/models/message_model.dart';
import 'package:chat_try_3/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialState());
  static ChatCubit get(BuildContext context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  ImagePicker imagePicker = ImagePicker();
  XFile? userImage;
  UserModel registeredUser = UserModel();
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<UserModel> users = [];
  List<MessageModel> allMessages = [];
  pickImage(String ch) async {
    if (ch == "cam") {
      userImage = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      userImage = await imagePicker.pickImage(source: ImageSource.gallery);
    }
  }

  registerByEmailAndPassword(String email, String name, String password) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    registeredUser.email = email;
    registeredUser.name = name;
    registeredUser.id = credential.user!.uid;
    await storage
        .ref()
        .child("images/")
        .child("${registeredUser.id}.jpg")
        .putFile(File(userImage!.path));
    registeredUser.photoUrl = await storage
        .ref()
        .child("images/")
        .child("${registeredUser.id}.jpg")
        .getDownloadURL();
    await firestore
        .collection("users")
        .doc(registeredUser.id)
        .set(registeredUser.toJson());
  }

  signInByGoogle() async {
    await googleSignIn.signOut();
    GoogleSignInAccount? gSignInAcc = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await gSignInAcc!.authentication;
    AuthCredential userCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    var user = await auth.signInWithCredential(userCredential);
    print(gSignInAcc.displayName);
    //print(user.user!.uid);

    UserModel gUser = UserModel(
      id: user.user!.uid,
      name: gSignInAcc.displayName,
      photoUrl: gSignInAcc.photoUrl,
      email: gSignInAcc.email,
    );
    await firestore.collection("users").doc(gUser.id).set(gUser.toJson());
    registeredUser = gUser;
    await getAllUsers();
  }

  login(String email, String password) async {
    await auth.signOut();
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    var qSnapShot =
        await firestore.collection("users").doc(userCredential.user!.uid).get();
    registeredUser = UserModel.fromJson(qSnapShot.data()!);
    print(registeredUser.toJson());
    getAllUsers();
  }

  getAllUsers() async {
    users = [];
    var qSnapShot = await firestore
        .collection("users")
        .where("id", isNotEqualTo: registeredUser.id)
        .get();
    qSnapShot.docs.forEach((element) {
      users.add(UserModel.fromJson(element.data()));
      emit(RefreshState());
    });
    emit(RefreshState());
  }

  getAllMessages(int index) async {
    allMessages = [];
    //[registeredUser.id, users[index].id]
    await firestore
        .collection("chats")
        .where("msgId", whereIn: [
          "${registeredUser.id}${users[index].id}",
          "${users[index].id}${registeredUser.id}"
        ])
        .snapshots()
        .listen((event) async {
          if (allMessages.isEmpty) {
            var messages = await firestore
                .collection("chats")
                .where("msgId", whereIn: [
                  "${registeredUser.id}${users[index].id}",
                  "${users[index].id}${registeredUser.id}"
                ])
                .orderBy("time")
                .get();

            messages.docs.forEach((element) {
              allMessages.add(MessageModel.fromJson(element.data()));
            });

            emit(RefreshState());
          } else {
            allMessages
                .add(MessageModel.fromJson(event.docChanges.first.doc.data()!));
            emit(RefreshState());
          }
        });
  }

  sendMessage(String msg, int index) async {
    MessageModel message = MessageModel(
        time: DateTime.now(),
        title: msg,
        senderId: registeredUser.id,
        msgId: "${registeredUser.id}${users[index].id}",
        recieverId: users[index].id);
    await firestore.collection("chats").doc().set(message.toJson());
  }
}
