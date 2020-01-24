import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:image_picker/image_picker.dart';
import "dart:io";






class UploadPhotoPage extends StatefulWidget
{
    State <StatefulWidget> createState()
    {
      return UploadPhotoPageState();
    }

    
}
 class UploadPhotoPageState extends State<UploadPhotoPage>
 {
   File sampleImage;
   String _myValue;
   final formKey = new GlobalKey<FormState>();

    Future getImage() async
    {
      var tempImage =  await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        sampleImage = tempImage;
      });
    }
    bool validateAndSave()
    {
      final form = formKey.currentState;
      if(form.validate())
      {
        form.save();
        return true;
      }
      else{
        return false;
      }
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("UploadImage"),
        centerTitle: true,
      ),
      body:  new Center(
        child: sampleImage == null? Text("Select an Image") : enableUpload(),
      ),
      floatingActionButton:  new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
   Widget enableUpload()
   {
return  Container(
 child: new Form(
    key: formKey,
  child: Column
  (
children: <Widget>[
  Image.file(sampleImage,height:310.0,width:600.0,),
  SizedBox(height: 15.0,),
  TextFormField(
    decoration: new InputDecoration(labelText: "Description"),
    validator: (value)
    {
      return value.isEmpty ?"Description is required" :null;
    },
    onSaved:(value) {
      return _myValue = value;
    }
      
      
      ,
  ),
  SizedBox(height: 15.0,),
  RaisedButton
  (
    elevation: 10.0,
    child: Text("Add a new post"),
    textColor: Colors.white,
    color: Colors.lightBlue, onPressed: validateAndSave,
  )
],
  ),
 
 ),
);
   }
 }
