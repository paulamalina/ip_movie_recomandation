import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:ip_movie_recomandation/data/data.dart';

class TestMe extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<TestMe> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];

  void postComment(String text) async {
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/comments");
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "text" : text,
          "commentDate": formattedDate,
          "appuser" : {
            "id" : "5"
          },
          "movie" : {
            "id" : "3"
          }
        }),
        headers: {
          "Authorization" : token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
          "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });

    print("Response: ${response.statusCode}");
    if (response.statusCode == 201) {
      print("post comment ok");
    } else {
      print("post comment not ok");
    }
  }

  String authToken =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJybWloYWxhY2hlQGdtYWlsLmNvbSIsImF1dGhvcml0aWVzIjpbeyJhdXRob3JpdHkiOiJtb3ZpZXM6cmVhZCJ9LHsiYXV0aG9yaXR5IjoiUk9MRV9VU0VSIn1dLCJpYXQiOjE2NTMxNDg0NTEsImV4cCI6MTY1NDMwMDgwMH0.07c60BOq7QjTZHVzuITSMSAZuoIlvOKyjVqrA-LB9PENNQnWe7ftbOc4rCMh71Hy601slCiwL4_XpOaYXOnU_w";


  void fetchComments(int id_movie) async {
    final response = await http.get(
        Uri.parse('http://157.230.114.95:8090/api/v1/movies/comments/' + id_movie.toString()),
        headers: {"Authorization": authToken});

    print("Status code: ${response.statusCode}");
    if (response.statusCode == 404) {
      //afisare text "niciun comentariu"
    } else if (response.statusCode == 200) {
      //generare comentarii
      //get "dupe"(sick) id user
      //populat filedata cu nume user, imagine de profil, data comentariu, text comentariu
      filedata=jsonDecode(response.body);
      print(filedata);
    }

  }




  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("current id : $currentId");
    return Scaffold(
      appBar: AppBar(
          title: Text("Comment Page"),
          backgroundColor: Color.fromRGBO(52, 160, 164, 1)),
      body: Container(
        child: CommentBox(
          userImage:
          "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic':
                  'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                  'message': commentController.text
                };
                filedata.insert(0, value);
                postComment(commentController.text);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}