import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everbrain/presentation/Screens/auth/login/loginScreen.dart';
import 'package:everbrain/presentation/Screens/dashboard/dashboard_Screen.dart';
import 'package:everbrain/presentation/Screens/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../controller/flutter_encry_controller.getx.dart';
import '../../controller/login_controller.getx.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import '../../presentation/Screens/auth/emailVerification/email_verify_Screen.dart';
import '../../presentation/Screens/auth/widget_Tree.dart';
import '../../presentation/Widget/loading.dart';
import '../localServices/secure_storage_repository.dart';

class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _collectionHintName = 'userHints';
  var userID ;


  //To get current user info
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  void currentUserID() {
    userID = _firebaseAuth.currentUser!.uid.toString();
  }

  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }

  //E-mail Sign Up
  Future signUp(String _email, String _password, String passwordHints, bool isAgree , var context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Loading();
        });

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) async{
        
        var userID = _firebaseAuth.currentUser!.uid;
        
        createUser(userID, _email, passwordHints, isAgree);

        Get.lazyPut(() => FlutterEncryController());

        var resultKey = await Get.find<FlutterEncryController>().masterPassStore(
            _password, userID);

        var resultEmailKey = await Get.find<FlutterEncryController>()
            .userEmailStore(_email, userID);

        if (resultKey == LocalStorageResult.saved
            && resultEmailKey == LocalStorageResult.saved) {
              
          Get.off(const VerifyEmailScreen());

        } else {
          Get.snackbar('Error', 'Login key error',
              backgroundColor: colors.AppColor.fail,
              colorText: colors.AppColor.secondaryColor,
              snackPosition: SnackPosition.BOTTOM);
              
          signOut();
        }
        
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString().split(']').last.trimLeft(),
          backgroundColor: colors.AppColor.fail,
          colorText: colors.AppColor.secondaryColor,
          snackPosition: SnackPosition.BOTTOM);

      Navigator.of(context).pop();
    }
  }

  //E-mail Sign In
  Future signIn(String email, String password, var context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Loading();
        });

    try {
      
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final loginController = Get.find<LoginController>();
        final encryController = Get.put(FlutterEncryController());

        currentUserID();

        var resultPassKey = await encryController.masterPassStore(
            password, userID);

        var resultEmailKey = await encryController.userEmailStore(
            email, userID);

        if (resultPassKey == LocalStorageResult.saved &&
            resultEmailKey == LocalStorageResult.saved) {
          loginController.email_field.clear();
          loginController.password_field.clear();
          
          var status = await currentUserEmailVerifiedStatus();

          if(status == true){
            Get.offAll(const MainScreen());

          }else{
            Get.offAll(const VerifyEmailScreen());

          }

        } else {
          Get.snackbar('Error', 'Login key error',
              backgroundColor: colors.AppColor.fail,
              colorText: colors.AppColor.secondaryColor,
              snackPosition: SnackPosition.BOTTOM);
              
          signOut();
        }
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString().split(']').last.trimLeft(),
          backgroundColor: colors.AppColor.fail,
          colorText: colors.AppColor.secondaryColor,
          snackPosition: SnackPosition.BOTTOM);

      Navigator.of(context).pop();
    }
  }

  Future signOut({BuildContext? context}) async {
    String id = _firebaseAuth.currentUser!.uid.toString();
    try {
      await FirebaseAuth.instance.signOut().then((value) async {
        Get.lazyPut(() => FlutterEncryController());

        var resultKey = await Get.find<FlutterEncryController>()
            .masterPassClear(id);
        if (resultKey == LocalStorageResult.deleted) {
          Get.offAll(LoginScreen());
        } else {
          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: const Text('Log out error. Try again in while'),
            backgroundColor: colors.AppColor.fail,
            duration: const Duration(seconds: 2),
          ));
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: colors.AppColor.fail,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future sendVerificationEmail(RxBool canResentEmail) async {
    try {
      final user = _firebaseAuth.currentUser!;
      await user.sendEmailVerification();

      canResentEmail.value = false;
      await Future.delayed(const Duration(seconds: 30));

      canResentEmail.value = true;
    } catch (e) {
      Get.snackbar('Error', e.toString().split(']').last.trimLeft(),
          backgroundColor: colors.AppColor.fail,
          colorText: colors.AppColor.secondaryColor,
          snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 10));
    }
  }

  Future currentUserEmailVerifiedStatus() async {
    return _firebaseAuth.currentUser!.emailVerified ;
  }

  Future checkEmailVerified(RxBool isEmailVerified) async {
    await _firebaseAuth.currentUser!.reload();
    isEmailVerified.value = _firebaseAuth.currentUser!.emailVerified;
  }

  Future resetPassword(String _email, var context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Loading();
        });

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: _email).then((value) {
        Get.snackbar('Reset Successfully', 'Check your email',
            backgroundColor: colors.AppColor.success,
            colorText: colors.AppColor.secondaryColor,
            snackPosition: SnackPosition.BOTTOM);
        Get.to(LoginScreen());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString().split(']').last.trimLeft(),
          backgroundColor: colors.AppColor.fail,
          colorText: colors.AppColor.secondaryColor,
          snackPosition: SnackPosition.BOTTOM);

      Navigator.of(context).pop();
    }
  }

  Future<void> createUser(String userID, String email, String hint, bool terms) async{

    var data = {
      'userID': userID,
      'userEmail': email,
      'hints': hint,
      'Terms and conditions' : terms ? 'Agree' : 'Disagree'
    };
    await _fireStore.collection(_collectionHintName).add(data).whenComplete(() => null)
    .catchError((onError, stackTrace){
      Get.snackbar('Error', onError.toString().split(']').last.trimLeft(),
          backgroundColor: colors.AppColor.fail,
          colorText: colors.AppColor.secondaryColor,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  Future<String?> getUserHints(String email) async{
    final hintDoc = await _fireStore.collection(_collectionHintName).where('userEmail', isEqualTo: email).get();
   // Map<String, dynamic> userData = hintDoc.data() as Map<String, dynamic>;
   if (hintDoc.docs.isNotEmpty) {
      // Get the first document (assuming user IDs are unique)
      DocumentSnapshot userDocument = hintDoc.docs[0];
      
      // Access the data within the document
      Map<String, dynamic> userData = userDocument.data() as Map<String, dynamic>;
      return userData['hints'].toString();

    }else{
      return 'No hint found';
    }
  }

}
