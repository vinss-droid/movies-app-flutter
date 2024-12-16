class Movie {
  final String title;
  final String backdropPath;
  final String overView;
  final String posterPath;

  Movie({required this.title, required this.backdropPath, required this.overView, required this.posterPath});

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      backdropPath: map['backdrop_path'],
      overView: map['overview'],
      posterPath: map['poster_path'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backdropPath': backdropPath,
      'overview': overView,
      'posterPath': posterPath,
    };
  }
}