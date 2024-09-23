import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:se_app/AllWidgets/progressdialog.dart';
import 'package:se_app/allscreens/loginscreen.dart';
import 'package:se_app/allscreens/mainscreen.dart';
import 'package:se_app/main.dart';

class registerationscreen extends StatelessWidget
{
  static const String idscreen = "registerationscreen";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
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
              SizedBox(height: 20.0,width: 900.0,),
              //  Positioned(
              //  top: 50.0,
              //  right: 50.0,
              // ),
              Image(
                image: AssetImage("images/eas_logo2.png"),
                width: 900.0,
                height: 255.0,
                alignment: Alignment.center,
              ),


              SizedBox(height: 15.0,),
              Text(
                "Sign Up as consumer",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                      children: [

                        SizedBox(height: 1.0,),
                        TextField(
                          controller: nameTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Name",
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
                          controller: phoneTextEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: "Phone no.",
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
                                "CREATE ACCOUNT",
                                style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          onPressed: ()
                          {
                            if(nameTextEditingController.text.length<4)
                            {
                              dynamic("Name must at least be 3 characters",context);
                            }
                            else if(!emailTextEditingController.text.contains("@"))
                              {
                                dynamic("Email id is invalid",context);
                              }
                            else if(phoneTextEditingController.text.length<10)
                            {
                              dynamic("Phone no. should be at least 10 numbers",context);
                            }
                            else if(passwordTextEditingController.text.length < 6)
                            {
                              dynamic("Password must be at least 6 characters",context);
                            }
                            else
                            {
                              registerNewUser(context);
                            }
                            },
                        )
                      ],
                    ),
                  ),




          FlatButton(
            onPressed: ()
            {
              Navigator.pushNamedAndRemoveUntil(context, loginscreen.idscreen, (route) => false);
            },
            child: Text(
              "Already have an account? Login here.",
              style: TextStyle(fontSize: 17.0,fontFamily: "Brand Bold"),
            ),
          ),

        ],
      ),
    )
    ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser (BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering ,Please wait....",);
        }
    );

    final User firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
        ).catchError((errMsg){
          Navigator.pop(context);
          dynamic("ERROR" + errMsg.toString(),context);
    })).user;


    if(firebaseUser !=null) //user created
      {
        Map userDataMap = {
          "name" : nameTextEditingController.text.trim(),
          "email" : emailTextEditingController.text.trim(),
          "phone" : phoneTextEditingController.text.trim(),
          "password" : passwordTextEditingController.text.trim(),
        };

        usersRef.child(firebaseUser.uid).set(userDataMap);
        dynamic("Congratulations! User has been created",context);
        
        Navigator.pushNamedAndRemoveUntil(context, mainscreen.idscreen, (route) => false);

        //save user info in database
    }
    else
      {
        Navigator.pop(context);
        dynamic("User has not been created",context);
        //error occured - display error msg
      }
  }
}

dynamic(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}