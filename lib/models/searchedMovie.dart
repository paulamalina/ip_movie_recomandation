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
    required this.ageRestriction,
    required this.comments,
    required this.description,
    required this.duration,
    required this.id,
    required this.movieGenres,
    required this.movieLink,
    required this.name,
    required this.ratings,
    required this.releaseDate,
    required this.summary,
    required this.thumbnailLink,
    required this.trailerLink,
  });

  int ageRestriction;
  List<Comment> comments;
  String description;
  int duration;
  int id;
  List<MovieGenre> movieGenres;
  String movieLink;
  String name;
  List<Rating> ratings;
  DateTime releaseDate;
  String summary;
  String thumbnailLink;
  String trailerLink;

  factory SearchedMovie.fromJson(Map<String, dynamic> json) => SearchedMovie(
        ageRestriction: json["ageRestriction"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        description: json["description"],
        duration: json["duration"],
        id: json["id"],
        movieGenres: List<MovieGenre>.from(
            json["movieGenres"].map((x) => MovieGenre.fromJson(x))),
        movieLink: json["movieLink"],
        name: json["name"],
        ratings:
            List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        releaseDate: DateTime.parse(json["releaseDate"]),
        summary: json["summary"],
        thumbnailLink: json["thumbnailLink"],
        trailerLink: json["trailerLink"],
      );

  Map<String, dynamic> toJson() => {
        "ageRestriction": ageRestriction,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "description": description,
        "duration": duration,
        "id": id,
        "movieGenres": List<dynamic>.from(movieGenres.map((x) => x.toJson())),
        "movieLink": movieLink,
        "name": name,
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "summary": summary,
        "thumbnailLink": thumbnailLink,
        "trailerLink": trailerLink,
      };
}

class Comment {
  Comment({
    required this.commentDate,
    required this.id,
    required this.text,
  });

  DateTime commentDate;
  int id;
  String text;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentDate: DateTime.parse(json["commentDate"]),
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "commentDate":
            "${commentDate.year.toString().padLeft(4, '0')}-${commentDate.month.toString().padLeft(2, '0')}-${commentDate.day.toString().padLeft(2, '0')}",
        "id": id,
        "text": text,
      };
}

class MovieGenre {
  MovieGenre({
    required this.genre,
    required this.id,
  });

  String genre;
  int id;

  factory MovieGenre.fromJson(Map<String, dynamic> json) => MovieGenre(
        genre: json["genre"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "genre": genre,
        "id": id,
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
