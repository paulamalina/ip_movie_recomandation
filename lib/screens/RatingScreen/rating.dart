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
            child:
            Container(
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
              child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    child: Stack(
                      children: [
                        Center(
                          child: Align(
                            alignment: FractionalOffset(0.5, 0.1),
                            child: Image.asset(globals.image),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                    spacing: 20,
                    alignment: WrapAlignment.spaceBetween,
                    children:[ 
                      Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.spaceBetween,
                      children:[
                        Container(
                          width: 150,
                          height: 80,
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
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ),

                        Container(
                          width: 150,
                          height: 80,
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
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                      ),
                      
                    Wrap(
                        spacing: 20,
                        alignment: WrapAlignment.spaceBetween,
                      children:[
                        Container(
                        width: 150,
                        height: 80,
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 150,
                        height: 80,
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
          
                    ),
                    ],
                    ),
                SizedBox(
                  height: 50,
                ),

                Container(
                  width: 150,
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
                  child: Text('Skip', style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ),
                  ],
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