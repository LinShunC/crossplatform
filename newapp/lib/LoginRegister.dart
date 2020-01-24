

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import 'Authentication.dart';

class LoginRegiser extends StatefulWidget 
{
  LoginRegiser({
    this.auth,
    this.onSignedIn,
  });
  final AuthImplementation auth ;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() {
   return LoginRegiserState();
     }
  
   }

   enum FormType
   {
     login,
     register
   }
   
   class LoginRegiserState extends State<LoginRegiser>
{

  final formKey = new GlobalKey<FormState>();
  FormType formType = FormType.login;
  String email = "";
  String password = "";



bool validateAndSave() {
  final form = formKey.currentState;
  if (form.validate()) 
  {
    form.save();
    return true;
  }
  else
  {
    return false;
  }
  /*//http.Response reponse = await http.post("http://localhost:3001/api/userValidation/validate");
String url = 'http://localhost:3001/api/userValidation/validate';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"username": "test@gmail.com", "password": "222222"}';
  // make POST request
  http.Response response = await http.post(url, headers: headers, body: json);
Map <String, dynamic> user = jsonDecode(response.body);
bool state = user['valid'];
String UID = user['userid'];
print(UID);
print(state);
if (state == false)
{
  print("error");
}
else{
print('Howdy, ${user['valid']}!');
}*/

}
void validateAndSubmit() async
{
if (validateAndSave())
{
  try
  {
if (formType == FormType.login)
{
  String userID = await widget.auth.signIn(email, password);
  print("user ID is :"+ userID);


}
else{
 String userID = await widget.auth.signUp(email, password);
  print("register user ID is :"+ userID);

}
widget.onSignedIn();
  }catch(e)
  {

    print("error:"+e.toString());
  }
  
}
}

 /* Future<Response> validateAndSave(String email, String password) async {
    final url = new Uri.https('baseUrl', '/users/authenticate');
    final credentials = '$email:$password';
    final basic = 'Basic ${base64Encode(utf8.encode(credentials))}';
    final json = await NetworkUtils.post(url, headers: {
      HttpHeaders.AUTHORIZATION: basic,
    });
    return Response.fromJson(json);
  }*/
   /*validateAndSave() async
  {
    final form = formKey.currentState;
    if (form.validate())
    {

    
      form.save();
      return true;
    }
    else
    {
      return false ;
    }
  }*/
    void moveToRegister(){

      formKey.currentState.reset();
      setState(() {
        formType = FormType.register;
     
      });
    }
     void moveToLogin(){

      formKey.currentState.reset();
      setState(() {
        formType = FormType.login;
      });
    }



  // ui design
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Shopping App")
      ),

       body: new Container(
         margin: EdgeInsets.all(15.0),
         child: new Form(

           key: formKey,
           child: new Column(
             crossAxisAlignment:CrossAxisAlignment.stretch,
children: createInputs() +createButtons(),
           ),
         ),
       ),
    );
    
  }
  List <Widget> createInputs()
  {
    return
    [
      SizedBox(height: 10.0,),
      logo(),
       SizedBox(height: 20.0,),
       new TextFormField(
         decoration: new InputDecoration(labelText: "Email"),

         validator:  (value)
         {
           return value.isEmpty ? "email is required" : null;
         },
         onSaved: (value)
         {
           return email = value;
         },
       ),
         SizedBox(height: 10.0,),
       new TextFormField(
         decoration: new InputDecoration(labelText: "Password"),
         obscureText: true,

          validator:  (value)
         {
           return value.isEmpty ? "password is required" : null;
         },
         onSaved: (value)
         {
           return password = value;
         },
       ),
         SizedBox(height: 20.0,),

    ];
  }

     Widget logo()
     {
       return new Hero(
         tag: "image",
         child: new CircleAvatar(
           backgroundColor: Colors.transparent,
           radius: 110.0,
           child: Image.asset('image/shopping.png'),
           
         ),
       );
     }
     List <Widget> createButtons()
  { 
    if(formType == FormType.login){
    return
    [
     new RaisedButton(  
       child: new Text("Login",style:  new TextStyle(fontSize: 20.0),),
       textColor: Colors.white,
       color: Colors.lightBlue,
        onPressed: validateAndSubmit,
     ),
         
          new FlatButton(  
       child: new Text("Not have an account",style:  new TextStyle(fontSize: 14.0),),
       textColor: Colors.black,
         onPressed: moveToRegister,
     )
    ];}
    else
    {
        return
    [
     new RaisedButton(  
       child: new Text("Register",style:  new TextStyle(fontSize: 20.0),),
       textColor: Colors.white,
       color: Colors.lightBlue,
        onPressed: validateAndSubmit,
     ),
         
          new FlatButton(  
       child: new Text("Already have an account",style:  new TextStyle(fontSize: 14.0),),
       textColor: Colors.black,
         onPressed: moveToLogin,
     )
    ];
    }

  }
}