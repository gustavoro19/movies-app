import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';


class DataSearch extends SearchDelegate {

  final moviesProvider = new MoviesProvider();

  final movies = [
    'SpiderMan',
    'Aquaman',
    'Batman',
    'Shazam',
    'Iron Man',
    'Capitan America',
    'Avengers',
  ];

  final recentMovies = [
    'Spider Man',
    'Capitan America'
  ];

  String selection = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      } ,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.indigoAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if ( query.isEmpty) {
      return Container();
    }

      return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        
        if ( snapshot.hasData ) {
          
          final moviesSnap = snapshot.data;

          return ListView(
            children: moviesSnap.map( (movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterimg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: (){
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            }).toList()
          ); 

        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );


  //  final searchSuggested = (query.isEmpty ) 
  //                           ? recentMovies
  //                           : movies.where(
  //                               (m) => m.toLowerCase().startsWith(query.toLowerCase()) 
  //                               ).toList();

  //   return ListView.builder(
  //     itemCount: searchSuggested.length,
  //     itemBuilder: (context, i){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(searchSuggested[i]),
  //         onTap: () {
  //           selection = searchSuggested[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  }



}