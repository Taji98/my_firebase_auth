import 'package:flutter/material.dart';
import 'package:my_firebase_auth/loginScreen.dart';
import 'package:my_firebase_auth/screens/auth/optscreen.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phonecontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inserisci il Tuo Numero"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Loginscreen()),
              (route) => false,
            );
          },
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.smartphone_rounded,
                size: 100,
                color: Colors.deepPurpleAccent,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                    hintText: "Numero di Telefono",
                    prefixIcon: Icon(Icons.smartphone),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent, width: 4),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(40.0),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=> VerificationCodeInputScreen(
                          phoneNumber: _phonecontroller.text)));
                    },
                    child: Text("Verifica", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
