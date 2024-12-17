import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_apps/model/movie_model.dart';
import 'package:movies_apps/api/api.dart';


class Home extends StatefulWidget {
    const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    upcomingMovies = Api().getUpcomingMovies();
    popularMovies = Api().getPopularMovies();
    topRatedMovies = Api().getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          foregroundColor: Colors.white,
          leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
          title: const Text('Show Spot'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.notifications)),
          ],
        ),
        // drawer: Drawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Upcoming', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ),
              FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snaphot) {
                    if (!snaphot.hasData) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    final movies = snaphot.data!;

                    return CarouselSlider.builder(
                      itemCount: movies.length,
                        itemBuilder: (context, index, movieIndex) {
                          final movie = movies[index];
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16/9,
                          autoPlayInterval: const Duration(seconds: 3),
                        )
                    );
                  }
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Popular', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 200,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snaphot) {
                    if (!snaphot.hasData) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    final movies = snaphot.data!;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          return Container(
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Top Rated', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 200,
                child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snaphot) {
                      if (!snaphot.hasData) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      final movies = snaphot.data!;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];

                            return Container(
                              width: 150,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                      );
                    }
                ),
              )
            ],
          ),
        ),
      );
  }
}