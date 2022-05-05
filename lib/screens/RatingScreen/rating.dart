import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  // @override
  void function(){
    if(globals.Index==0){
      globals.image='assets/images/image1.png';
      globals.Index++;
    }else
    if(globals.Index==1){
      globals.image='assets/images/image2.png';
      globals.Index++;
    }else
    if(globals.Index==2){
      globals.image='assets/images/image3.png';
      globals.Index++;
    }else
    if(globals.Index==3){
      globals.image='assets/images/image4.png';
      globals.Index++;
    }else
    if(globals.Index==4){
      globals.image='assets/images/image5.png';
      globals.redirect="/main";
      globals.Index++;
    }
  }

  void reduceIndex(){ globals.Index--;}

  double containerWidth=700;
  double containerHeight=850;
  bool isSmallScreen=false;
  bool isLargeScreen=true;
  void setValue(){
    if(MediaQuery.of(context).size.width >= 700){
      setState(() {
        containerWidth=700;
        containerHeight=850;
        isSmallScreen=false;
        isLargeScreen=true;
      });
    }else{
      setState(() {
        containerWidth=double.infinity;
        containerHeight=double.infinity;
        isSmallScreen=true;
        isLargeScreen=false;

      });
    }
  }
@override
  Widget build(BuildContext context) {
    function();
    setValue();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
          )
        ],
        gradient: LinearGradient(colors: [
          Colors.white, Color.fromRGBO(52, 160, 164, 1)
        ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                boxShadow: isLargeScreen ? [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 2,
                  )
                ] : null,
                borderRadius: isLargeScreen ? BorderRadius.circular(50.0) : null,
                color: Colors.teal,
              ),
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
          ),

      ),
    );

    //Image.asset('./assets/images/image1.jpg');
  }
}