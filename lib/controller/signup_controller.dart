import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/model/signup_model.dart';
import 'package:to_do/view/homepage.dart';

class SignupController extends GetxController {
  late Box<SignupModel> signupBox;
  RxBool signupLoading = false.obs;
  RxBool signinLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    signupBox = Hive.box<SignupModel>('signupBox');
  }

  void signupUser(String name, String emailId, String password) async {
    try {
      signupLoading(true);
      final isExistingUser =
          signupBox.values.any((user) => user.emailId == emailId);

      if (isExistingUser) {
        Get.snackbar(
          "Already Registered",
          "This email is already in use.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      } else {
        final signupModel = SignupModel(name, emailId, password);
        await signupBox.add(signupModel);

        Get.snackbar(
          "Success",
          "User signed up successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("error occured while adding $e");
    } finally {
      signupLoading(false);
    }
  }

  void signInUser(String emailId, String password) async {
    try {
      signinLoading(true);

      final matchedUser = signupBox.values.firstWhereOrNull(
        (user) => user.emailId == emailId && user.password == password,
      );

      if (matchedUser != null) {
        // Successful login
        Get.snackbar(
          "Success",
          "Logged in successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to home screen or next page
        Get.offAll(() => const Homepage());
      } else {
        Get.snackbar(
          "Login Failed",
          "Invalid email or password.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error during login: $e");
      Get.snackbar(
        "Error",
        "Something went wrong.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      signinLoading(false);
    }
  }
}
