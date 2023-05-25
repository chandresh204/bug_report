import 'package:bug_report/project_info_screen.dart';
import 'package:bug_report/project_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  int _currentUIStep = 0;
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in'),),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    switch(_currentUIStep) {
      case 0 : {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _numController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number with Country code',
                    hintText: 'e.g. +918888888',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(height: 20,),
              ElevatedButton(onPressed: () {
                if (_numController.text.isEmpty || !_numController.text.contains('+')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please provide valid value'))
                  );
                  return;
                }
                _verifyNumber(_numController.text);
                setState(() { _currentUIStep = 1; });
              }, child: const Text('Verify'))
            ],
          ),
        );
      }
      case 1 : {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      case 2: {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(onPressed: () {
                _submitOtp(_otpController.text);
              }, child: const Text('Submit'))
            ],
          ),
        );
      }
      case 3 : {
        Future.delayed(const Duration(seconds: 5), () {
          setState(() { _currentUIStep = 0; });
        });
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.error, color: Colors.red,),
              Text('Failed, Please try again', style: TextStyle(fontSize: 22),)
            ],
          ),
        );
      }
      default: {
        return Container();
      }
    }
  }

  _verifyNumber(String number) async {
    await Constants.auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) { },
        verificationFailed: (error) {
          setState(() { _currentUIStep = 3; });
        },
        codeSent: (String verificationID, int? forceResendToken) {
          verificationId = verificationID;
          setState(() { _currentUIStep = 2; });
        },
        codeAutoRetrievalTimeout: (String vId) {});
  }

  _submitOtp(String otp) async {
    setState(() { _currentUIStep = 1; });
    AuthCredential authCredential =
      PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
    await Constants.auth.signInWithCredential(authCredential)
      .whenComplete(() {
        if(Constants.auth.currentUser == null) {
          setState(() { _currentUIStep = 3; });
          return;
        }
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => const ProjectListPage()), (route) => false);
    });
  }
}
