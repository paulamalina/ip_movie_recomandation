import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:ip_movie_recomandation/data/data.dart';

class Comment extends StatefulWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  var filedata = [];
  var hour = DateTime.now().hour.toString();
  var minute = DateTime.now().minute.toString();
  String time = "x";

  void goodTime() {
    time = hour + ":" + minute;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pop(context);
          });
          return alert;
        });
  }

  bool checkVar = false;

  void postComment(String text) async {
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/comments");
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "text": text,
          "commentDate": formattedDate,
          "movie": {"id": currentId}
        }),
        headers: {
          "Authorization": token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });
  }

  String name = "";

  var listComments = [];

  Future fetchComments() async {
    checkVar = true;

    getName();
    final response = await http.get(
        Uri.parse('http://157.230.114.95:8090/api/v1/movies/comments/' +
            currentId.toString()),
        headers: {"Authorization": token}); //inlocuit cu token de mai sus

    if (response.statusCode == 404) {
      //afisare text "niciun comentariu"
    } else if (response.statusCode == 200) {
      //filedata=jsonDecode(response.body);

      listComments = jsonDecode(response.body);
    }
    return listComments;
  }

  void getName() async {
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/identity");
    final response = await http.get(apiUrl, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type": "application/json",
      "Authorization": token
    });
    var data = jsonDecode(response.body);
    name = data["name"];
  }

  Widget commentChild() {
    goodTime();
    return FutureBuilder(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox(
              child: Center(child: CircularProgressIndicator()),
              width: 100,
              height: 100,
            );
          } else {
            return ListView(
              children: [
                for (var i = 0; i < listComments.length; i++)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Display the image in large form.
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/images/userAvatar.png"),
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 20,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Text(
                                  listComments[i]["appUser"]["name"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text(listComments[i]['text']),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Text(listComments[i]['commentDate']),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                //isThreeLine: true,
              ],
            );
            //),
            //],
            // );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Comment Page"),
          backgroundColor: const Color.fromRGBO(52, 160, 164, 1)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: CommentBox(
          userImage:
              "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          child: commentChild(),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              //listComments.insert(0, value);
              postComment(commentController.text);
              showLoaderDialog(context);

              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {}
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget:
              const Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
