import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_try/main.dart';



class LoginPage extends StatefulWidget{
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{


   String _email='';
   String _pass='';


  @override
  Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor: Color(0xfff2f3f7),
         body: Stack(
           children: <Widget>[
             Container(
               height: MediaQuery.of(context).size.height * 0.7,
               width: MediaQuery.of(context).size.width,
               child: Container(
                 decoration: BoxDecoration(
                   color: Color(0xff2470c7),
                   borderRadius: BorderRadius.only(
                     bottomLeft: const Radius.circular(70),
                     bottomRight: const Radius.circular(70),
                   ),
                 ),
               ),
             ),
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 _buildLogo(),
                 _buildContainer(),
                 _buildSignUpBtn(),
               ],
             )
           ],
         ),
       ),
     );
  }

  Widget _buildLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'Instathing',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator:(String? value){
          if(value!.isEmpty){
            return 'Please enter an email id';
          }
          return null;
        },
        onChanged: (value){
          setState(() {
            _email=value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email
          ),
          labelText: 'email id'
        ),
      ),
    );
  }

  Widget _buildPasswordRow(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (String? value){
          if(value!.isEmpty){
            return 'Please enter a password';
          }
          if(value.length < 6){
            return'Password should contain more than 5 characters';
          }
          return null;
        },
        onChanged: (value){
          setState(() {
            _pass=value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock
          ),
          labelText: 'password',
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: (){

          },
          child: Text("Forget password"),
        ),
      ],
    );
  }

  Widget _buildLoginButton(){
    final ButtonStyle style= ElevatedButton.styleFrom(
      primary: Colors.blue,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
              style: style,
              onPressed: (){
              _signinWithEmailAndPassword();
              },
              child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Text(
            '- OR -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

Widget _buildContainer(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
             color: Colors.white,
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),

                    ),
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildForgetPasswordButton(),
                _buildLoginButton(),
                _buildOrRow(),
              ],
            ),
          ),
        ),
      ],
    );
}

Widget _buildSignUpBtn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: TextButton(
            onPressed: (){},
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Dont have an account ? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ]
              ),
            ),
          ),
        ),
      ],
    );
}

void _signinWithEmailAndPassword() async {
  try {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _pass
    ).then((result){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => AuthCheck()),
      );
    }).catchError((err){
      print(err.message);
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Error"),
            content: Text(err.message),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }) as UserCredential;//FutureOr<UserCredential>);


  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

}


}