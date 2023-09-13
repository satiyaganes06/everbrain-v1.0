import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everbrain/presentation/Screens/auth/login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/flutter_encry_controller.dart';
import '../../Controller/login_controller.dart';
import '../../Controller/signup_controller.dart';
import 'package:everbrain/utils/colors.dart' as colors;
import '../../presentation/Screens/email_verify_Screen.dart';
import '../../presentation/Widget/loading.dart';
import '../localServices/secure_storage_repository.dart';

class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _collectionHintName = 'userHints';

  //To get current user info
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }

  //E-mail Sign Up
  Future signUp(String _email, String _password, var context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Loading();
        });

    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        final signUPControl = Get.find<SignUpController>();

        createUser(_firebaseAuth.currentUser!.uid, signUPControl.passwordHints.text, signUPControl.isAgree);

        signUPControl.emailField.clear();
        signUPControl.passwordField.clear();
        signUPControl.repasswordField.clear();
        signUPControl.passwordHints.clear();
        Get.off(const VerifyEmailScreen());
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
  Future signIn(String _email, String _password, var context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Loading();
        });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.tr, password: _password)
          .then((value) async {
        final loginController = Get.find<LoginController>();
        final encryController = Get.find<FlutterEncryController>();

        var resultKey = await encryController.masterPassStore(
            _password, _firebaseAuth.currentUser!.uid.toString());

        if (resultKey == LocalStorageResult.saved) {
          loginController.email_field.clear();
          loginController.password_field.clear();

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

  Future signOut({BuildContext? context}) async {
    String id = _firebaseAuth.currentUser!.uid.toString();
    try {
      await FirebaseAuth.instance.signOut().then((value) async {
        final encryController = Get.find<FlutterEncryController>();
        var resultKey = await encryController
            .masterPassClear(id);
        debugPrint("Helloo" + resultKey.toString());
        if (resultKey == LocalStorageResult.deleted) {
          debugPrint("Helloo" + resultKey.toString());
          Get.off(LoginScreen());
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
          snackPosition: SnackPosition.BOTTOM);
    }
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

  Future<void> createUser(String userID, String hint, bool terms) async{

    var data = {
      'userID': userID,
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

  Future<String?> getUserHints() async{
    final hintDoc = await _fireStore.collection(_collectionHintName).where('userID', isEqualTo: _firebaseAuth.currentUser!.uid).get();
   // Map<String, dynamic> userData = hintDoc.data() as Map<String, dynamic>;
   if (hintDoc.docs.isNotEmpty) {
      // Get the first document (assuming user IDs are unique)
      DocumentSnapshot userDocument = hintDoc.docs[0];
      
      // Access the data within the document
      Map<String, dynamic> userData = userDocument.data() as Map<String, dynamic>;
      return userData['hints'].toString();

    }else{
      return 'No hints';
    }
  }

}
