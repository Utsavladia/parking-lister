
import 'package:doctor_app/authentication/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){

    if(!emailTextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg: "Please check the email address!");
    }

    else if(passwordTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Password is mandatory.");
    }
    else{
      loginDoctorNow();
    }

  }
  loginDoctorNow() async {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Logging in ...",);
        }
    );
    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      DatabaseReference doctorsRef = FirebaseDatabase.instance.ref().child("doctors");
      doctorsRef.child(firebaseUser.uid).once().then((doctorkey)
      {
        final snap = doctorkey.snapshot;
        if(snap.value != null){
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Logged in Successfully.");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }else{
          Fluttertoast.showToast(msg: "No record exist with this email");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });

    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error occurred during login.");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.lightBlueAccent,

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(20.0),

          child: Column(
            children: [
              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/profile.png"),
              ),
              const SizedBox(height: 10,),

              const Text(
                "Login as\nParking provider",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,

                ),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 15,),



              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style:const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),

              ),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style:const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),

              ),

              const SizedBox(height: 20,),

              ElevatedButton(onPressed:()
              {
                validateForm();
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.all(10),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25
                  ),
                ),
              ),

              TextButton(
                child:const Text(
                  "Don't have an account? Signup Here",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(c)=>SignUpScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
