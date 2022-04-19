import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class RatingScreen extends StatelessWidget {
  const RatingScreen({Key? key}) : super(key: key);

  // @override
  // State<RatingScreen> createState() => RatingScreen();
  void function(){
    if(globals.Index==0){
      globals.image='images/image1.png';
      globals.Index++;
    }else
    if(globals.Index==1){
      globals.image='images/image2.png';
      globals.Index++;
    }else
    if(globals.Index==2){
      globals.image='images/image3.png';
      globals.Index++;
    }else
    if(globals.Index==3){
      globals.image='images/image4.png';
      globals.Index++;
    }else
    if(globals.Index==4){
      globals.image='images/image5.png';
      globals.redirect="/main";
      globals.Index++;
    }
  }
  void reduceIndex(){ globals.Index--;}
  

@override
  Widget build(BuildContext context) {function();
    return Scaffold(
      
      backgroundColor: Color(0xff34A0A4),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xff1A759F),
        title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  Image.asset(
                 'images/logo.png',
                  fit: BoxFit.contain,
                  height: 54,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0), 
                  //child: Text('YourAppTitle')
                  )
            ],
        ),
      ),

        body: Container(
       //mainAxisAlignment: MainAxisAlignment.center,
        child: new Stack(
        children: [
          
        Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              
              child: Stack(
                children: [
                  Center(
                    child: Align(
                      alignment: FractionalOffset(0.5, 0.1),
                    child: 
                    
                    Image.asset(globals.image),
                  
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Center(
            child: Align(
                alignment: FractionalOffset(0.2, 0.8),
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xff76C893),
              ),
            
              
              child: TextButton(
                onPressed: () {
                  //function();
                  Navigator.pushNamed(context, globals.redirect);
                } ,
                child: Text('Awful', style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              
            ),
            ),
          ),
          Center(child: Align(
                alignment: FractionalOffset(0.4, 0.8),
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xff99D98C),
              ),
            
              
              child: TextButton(
                onPressed: () {
                  //function();
                  Navigator.pushNamed(context, globals.redirect);
                } ,
                child: Text('Average', style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              
            ),
            ),
            ),
            Center(child: Align(
                alignment: FractionalOffset(0.6, 0.8),
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xffB5E48C),
              ),
            
              
              child: TextButton(
                onPressed: () {
                  //function();
                  Navigator.pushNamed(context, globals.redirect);
                } ,
                child: Text('Good', style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              
            ),
            ),
            ),
            Center(child: Align(
                alignment: FractionalOffset(0.8, 0.8),
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xffD9ED92),
              ),
            
              
              child: TextButton(
                onPressed: () {
                  //function();
                  Navigator.pushNamed(context, globals.redirect);
                } ,
                child: Text('Amazing', style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              
            ),
            ),
            
            ),
            Center(child: Align(
                alignment: FractionalOffset(0.5, 0.95),
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xff1A759F),
              ),
            
              
              child: TextButton(
                onPressed: () {
                  //function();
                  Navigator.pushNamed(context, globals.redirect);
                } ,
                child: Text('Have not seen yet...', style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              
            ),
            ),
            
            ),
          
          
        ],
        ),
        
      ),
     
    );
    
    //Image.asset('./assets/images/image1.jpg');
  }
   
}