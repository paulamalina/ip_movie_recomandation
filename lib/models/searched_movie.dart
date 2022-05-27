// To parse this JSON data, do
//
//     final searchedMovie = searchedMovieFromJson(jsonString);

import 'dart:convert';

List<SearchedMovie> searchedMovieFromJson(String str) =>
    List<SearchedMovie>.from(
        json.decode(str).map((x) => SearchedMovie.fromJson(x)));

String searchedMovieToJson(List<SearchedMovie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchedMovie {
  SearchedMovie({
    required this.id,
    required this.name,
    required this.summary,
    required this.description,
    required this.ageRestriction,
    required this.movieGenres,
    required this.releaseDate,
    required this.duration,
    required this.trailerLink,
    required this.movieLink,
    required this.ratings,
    required this.comments,
  });

  int id;
  String name;
  String summary;
  String description;
  int ageRestriction;
  List<MovieGenre> movieGenres;
  DateTime releaseDate;
  int duration;
  String trailerLink;
  String movieLink;
  List<Rating> ratings;
  List<Comment> comments;

  factory SearchedMovie.fromJson(Map<String, dynamic> json) => SearchedMovie(
        id: json["id"],
        name: json["name"],
        summary: json["summary"],
        description: json["description"],
        ageRestriction: json["ageRestriction"],
        movieGenres: List<MovieGenre>.from(
            json["movieGenres"].map((x) => MovieGenre.fromJson(x))),
        releaseDate: DateTime.parse(json["releaseDate"]),
        duration: json["duration"],
        trailerLink: json["trailerLink"],
        movieLink: json["movieLink"],
        ratings:
            List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "summary": summary,
        "description": description,
        "ageRestriction": ageRestriction,
        "movieGenres": List<dynamic>.from(movieGenres.map((x) => x.toJson())),
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "trailerLink": trailerLink,
        "movieLink": movieLink,
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.text,
    required this.commentDate,
  });

  int id;
  String text;
  DateTime commentDate;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        text: json["text"],
        commentDate: DateTime.parse(json["commentDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "commentDate":
            "${commentDate.year.toString().padLeft(4, '0')}-${commentDate.month.toString().padLeft(2, '0')}-${commentDate.day.toString().padLeft(2, '0')}",
      };
}

class MovieGenre {
  MovieGenre({
    required this.id,
    required this.genre,
  });

  int id;
  String genre;

  factory MovieGenre.fromJson(Map<String, dynamic> json) => MovieGenre(
        id: json["id"],
        genre: json["genre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "genre": genre,
      };
}

class Rating {
  Rating({
    required this.id,
    required this.reviewValue,
  });

  int id;
  int reviewValue;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        reviewValue: json["reviewValue"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reviewValue": reviewValue,
      };
}
