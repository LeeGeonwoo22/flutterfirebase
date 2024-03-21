import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPhonePage extends StatefulWidget {
  const LoginPhonePage({Key? key}) : super(key: key);

  @override
  _LoginPhonePageState createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  bool _codeSent = false;
  late String _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase App")),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                phoneNumberInput(),
                const SizedBox(height: 15),
                _codeSent ? const SizedBox.shrink() : submitButton(),
                const SizedBox(height: 15),
                _codeSent ? smsCodeInput() : const SizedBox.shrink(),
                const SizedBox(height: 15),
                _codeSent ? verifyButton() : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField phoneNumberInput() {
    return TextFormField(
      controller: _phoneController,
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'The input is empty.';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input your phone number.',
        labelText: 'Phone Number',
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
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

  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_key.currentState!.validate()) {
          await verifyPhoneNumber();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "Send SMS Code",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  ElevatedButton verifyButton() {
    return ElevatedButton(
      onPressed: () async {
        await signInWithPhone();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "Verify",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
Future<void> verifyPhoneNumber() async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+44 7123 123 456',
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {},
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
  // Future<void> verifyPhoneNumber() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: _phoneController.text,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // This callback will be invoked in an automatic verification flow,
  //       // such as the device automatically detecting the SMS and verifying the code without user action.
  //       await auth.signInWithCredential(credential);
  //       Navigator.pushNamed(context, "/"); // Navigate to your desired screen after successful login
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print("The provided phone number is not valid.");
  //       }
  //     },
  //     codeSent: (String verificationId, int? forceResendingToken) async {
  //       setState(() {
  //         _codeSent = true;
  //         _verificationId = verificationId;
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // This callback will be invoked when the auto-retrieval timeout has elapsed
  //       // (e.g., when the code auto-retrieval process has not received an SMS code within a reasonable amount of time).
  //       print("Handling code auto retrieval timeout");
  //     },
  //   );
  // }

  Future<void> signInWithPhone() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsCodeController.text,
    );
    await auth.signInWithCredential(credential);
    Navigator.pushNamed(context, "/"); // Navigate to your desired screen after successful login
  }
}
