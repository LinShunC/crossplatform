import 'package:flutter/material.dart';
import 'Authentication.dart';



class home extends StatefulWidget
{
  home({
    this.auth,
    this.onSignedOut,
  });
   final AuthImplementation auth ;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState


    return homePageState();
  }
}

  class homePageState extends State <home>
  {

    void logout() async
    {
      try{
        await widget.auth.signOut();
        widget.onSignedOut();
      }
      catch(e)
      {
        print("error:"+e.toString());
      }
    }
    void shoppingCart(){}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      appBar: new AppBar(
        title:  new Text("Home"),
      ),
      body: new Container(

      ),
      bottomNavigationBar: new BottomAppBar(

      color: Colors.lightBlue,
      child: new Container(
        margin: const EdgeInsets.only(left:50.0,right:50.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.local_car_wash),
              iconSize: 50,
              color: Colors.white, onPressed: logout,
            ),
            new IconButton(
              icon: new Icon(Icons.shopping_cart),
              iconSize: 40,
              color: Colors.white, onPressed: shoppingCart,
            ),
          ],
        ),
      ),
      ),
    );
  }
  
  }
  
