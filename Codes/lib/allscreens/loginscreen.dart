import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:se_app/AllWidgets/progressdialog.dart';
import 'package:se_app/allscreens/mainscreen.dart';
import 'package:se_app/allscreens/registerationscreen.dart';
import 'package:se_app/main.dart';

class loginscreen extends StatelessWidget
{
  static const String idscreen = "loginscreen";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 15.0,width: 900.0,),
            //  Positioned(
              //  top: 50.0,
              //  right: 50.0,
             // ),
              Image(
                image: AssetImage("images/eas_logo2.png"),
                width: 900.0,
                height: 375.0,
                alignment: Alignment.center,
              ),


              SizedBox(height: 15.0,),
              Text(
                "Login as consumer",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                      children: [

                        SizedBox(height: 1.0,),
                        TextField(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              fontSize: 30.0,

                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,

                            )
                          ),
                          style: TextStyle(fontSize: 14.0),
                        ),


                        SizedBox(height: 1.0,),
                        TextField(
                          controller: passwordTextEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize: 30.0,

                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,

                            ),
                          ),
                          style: TextStyle( fontSize: 14.0),
                        ),

                        SizedBox(height: 20.0,),
                        RaisedButton(
                          color: Colors.yellow,
                          textColor: Colors.black,
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          onPressed: ()
                          {
                            if(!emailTextEditingController.text.contains("@"))
                            {
                              dynamic("Email id is invalid",context);
                            }
                            else if(passwordTextEditingController.text.isEmpty)
                            {
                              dynamic("Password cannot be empty",context);
                            }
                            else
                            {
                              loginAndAuthenticateUser(context);
                            }

                          },
                        )
                      ],
                    ),
                  ),


              FlatButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, registerationscreen.idscreen, (route) => false);
                },
                child: Text(
                  "Do not have an account? Register here.",
                  style: TextStyle(fontSize: 17.0,fontFamily: "Brand Bold"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
        {
          return ProgressDialog(message: "Authenticating ,Please wait....",);
        }
    );

    final User firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      dynamic("ERROR" + errMsg.toString(),context);
    })).user;

    if(firebaseUser !=null)
    {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap)
      {
        if(snap.value !=null)
        {
          Navigator.pushNamedAndRemoveUntil(context, mainscreen.idscreen, (route) => false);
          dynamic(" You have successfully logged-in!",context);
        }
        else
        {
            Navigator.pop(context);
            _firebaseAuth.signOut();
            dynamic("No record found",context);
        }
      });
      //save user info in database
    }
    else
    {
      Navigator.pop(context);
      dynamic("Error occured cannot be signed-in",context);
      //error occured - display error msg
    }

  }
}
