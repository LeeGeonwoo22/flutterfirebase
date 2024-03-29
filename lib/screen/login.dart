import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _smsCodeController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            loginForm(context),
            smsCodeInput(),
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      onPressed: () {
        signInPhone(); // signInPhone 함수 호출
      },
      child: Text('Sign In'),
    );
  }

  @override
  Widget loginForm(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      autofocus: true,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        // Add any additional validation here if needed
        return null;
      },
    );
  }

  TextFormField smsCodeInput() {
    return TextFormField(
      controller: _smsCodeController,
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'The input is empty.';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input your sms code.',
        labelText: 'SMS Code',
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> signInPhone() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print(auth.verifyPhoneNumber);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+821022024671', // 올바른 형식으로 수정됨
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('here');
          print(credential);
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // 여기서 e.message를 출력합니다.
          print(
              'The verification failed for the following reason: ${e.message}');
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          } else {
            // 에러 코드와 함께 더 상세한 에러 메시지를 출력합니다.
            print('Error code: ${e.code}, Message: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // 이 부분은 사용자 입력을 받은 후 처리해야 합니다.
        },
        codeAutoRetrievalTimeout: (String verificationId) {},

        // await FirebaseAuth.instance.verifyPhoneNumber(
        //   phoneNumber: '+821022024671',
        //   verificationCompleted: (PhoneAuthCredential credential) {
        //     print('complete');
        //     print(credential);
        //   },
        //   verificationFailed: (FirebaseAuthException e) {
        //     print(e);
        //     if (e.code == 'invalid-phone-number') {
        //       print('The provided phone number is not valid.');
        //     }
        //   },
        //   codeSent: (String verificationId, int? resendToken) {},
        //   codeAutoRetrievalTimeout: (String verificationId) {},
      );
      print('message sending');
      // await FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: '+82 10 2202 4671', // 올바른 형식으로 수정됨
      //   verificationCompleted: (PhoneAuthCredential credential) async {
      //     await auth.signInWithCredential(credential);
      //   },
      //   verificationFailed: (FirebaseAuthException e) {
      //     // 여기서 e.message를 출력합니다.
      //     print(
      //         'The verification failed for the following reason: ${e.message}');
      //     if (e.code == 'invalid-phone-number') {
      //       print('The provided phone number is not valid.');
      //     } else {
      //       // 에러 코드와 함께 더 상세한 에러 메시지를 출력합니다.
      //       print('Error code: ${e.code}, Message: ${e.message}');
      //     }
      //   },
      //   codeSent: (String verificationId, int? resendToken) async {
      //     // 이 부분은 사용자 입력을 받은 후 처리해야 합니다.
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {},
    } catch (e) {
      print('An error occurred during phone authentication: $e');
    }
  }
}

// codeSent: (String verificationId, int? resendToken) async {
// // 다이얼로그를 표시하여 사용자로부터 SMS 코드를 입력받습니다.
// // 예시 코드는 다이얼로그 구현 방법을 간략하게 보여줍니다.
// String? smsCode = await showDialog(
// context: context, // context를 올바르게 참조해야 합니다.
// builder: (context) => AlertDialog(
// title: Text("Enter SMS Code"),
// content: smsCodeInput(), // 여기에서 smsCodeInput() 호출
// actions: [
// TextButton(
// child: Text("Confirm"),
// onPressed: () {
// Navigator.of(context).pop(_smsCodeController.text);
// },
// ),
// ],
// ),
// );
//
// if (smsCode != null) {
// PhoneAuthCredential credential = PhoneAuthProvider.credential(
// verificationId: verificationId, smsCode: smsCode);
// try {
// await auth.signInWithCredential(credential);
// } catch (e) {
// print("Failed to sign in: $e");
// }
// }
// },
