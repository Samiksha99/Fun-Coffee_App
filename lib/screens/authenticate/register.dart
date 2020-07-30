import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

   final AuthService _auth = AuthService();
   final _formKey = GlobalKey<FormState>();
   bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
         actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In')
            )
        ], 
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children:<Widget>[
                SizedBox(height:20.0),
                Image.asset('assets/coffee.jpg'),  
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an Email': null,
                  decoration: textInputDecoration.copyWith(hintText:'Email',prefixIcon: Icon(Icons.email)),
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val) => val.length<6 ? 'Enter a password more than 6 characters ': null,
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(hintText:'Password',prefixIcon: Icon(Icons.lock)),
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height:20.0),
                RaisedButton(
                  color: Colors.pink,
                  child: Text(
                    'Register',
                    style: TextStyle(color:Colors.white),
                    ),
                    onPressed: ()async{
                     if(_formKey.currentState.validate()){
                       setState(() => loading = true);
                       dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                       if(result == null){
                         setState(() {error = 'Enter a valid email';
                         loading = false;
                         });
                       }

                     }
                    },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ]
            ))
        ),
      
    );
  }
}