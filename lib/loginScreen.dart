import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_firebase_auth/screens/auth/homeScreen.dart';
import 'package:my_firebase_auth/screens/auth/phoneinput.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final user = await _auth.signInWithCredential(credential);
      print(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithEmail(BuildContext context) async {
    UserCredential userCredential;

    try {
      // Prova a fare il login
      userCredential = await _auth.signInWithEmailAndPassword(
        email: "test@gmail.com",
        password: "test123",
      );
    } catch (e) {
      // Se fallisce (es. utente non esiste), crea un nuovo account
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: "test@gmail.com",
        password: "test123",
      );
    }

    // Dopo login o registrazione, se c'è un utente, vai alla home
    if (userCredential.user != null) {
      print("Login effettuato: ${userCredential.user!.email}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    }
  }

  Future<void> _signInWithPhone() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      appBar: AppBar(title: Text("Login", textAlign: TextAlign.center,),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 40,
      fontWeight: FontWeight.bold,
      ),
      leading: Icon(Icons.account_circle_rounded, size: 40,),
      leadingWidth: 120,
    backgroundColor: Colors.blueAccent,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              ElevatedButton.icon(
                label: Text("Sign in with Google"),
                onPressed: () {
                  _signInWithGoogle(context);
                },
                icon: Icon(Icons.favorite),
              ),

              SizedBox(height: 8),
              ElevatedButton.icon(
                label: Text("Sign in with Email"),
                onPressed: () {
                  _signInWithEmail(context);
                },
                icon: Icon(Icons.email),
              ),

              SizedBox(height: 8),
              ElevatedButton.icon(
                label: Text("Sign in with Phone"),
                icon: Icon(Icons.smartphone),
                onPressed: (){
                  Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context)=> PhoneInputScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
