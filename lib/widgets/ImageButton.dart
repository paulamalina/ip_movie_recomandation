import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String text;
  final Image image;
  const ImageButton({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: 
      Container(
        decoration: BoxDecoration(      
        color: Color(0xFFCAEEE4),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFF2B6086), width: 2)
        ),
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/details');
              },  
              icon: image,
              iconSize: 250,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF1A759F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              child:
              Container(
                width: 200,
                height: 40,
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), 
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff168AAD),
                ),
                child: Center(
                  child: Text(
                        "Add to watchlist",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                ),
                onTap:(){
     
                 },
                )
            
          ],
        )
        
        
      )
    );
    // return Padding(
    //     padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
    //     child: InkWell(
    //       onTap: () {
    //         Navigator.pushNamed(context, '/details');
    //       },
    //       child: Container(
    //         decoration: BoxDecoration(      
    //           color: Color(0xFFCAEEE4),
    //           borderRadius: BorderRadius.circular(30),
    //           border: Border.all(color: Color(0xFF2B6086), width: 2),
    //         ),
    //         padding: const EdgeInsets.all(20),
    //         child: Column(
    //           children: [
    //             image,
    //             Text(
    //               text,
    //               style: TextStyle(
    //                 color: Color(0xFF1A759F),
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
  }
}
