import 'package:flutter/material.dart';
import 'package:movies/src/models/cast_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';
// import 'package:movies/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0, ),
                _posterTitle( movie, context ),
                _description( movie ),
                _createCasting( movie )
              ]
            ),
          )
        ],
      ),
      
    );
  }

   Widget _createAppbar(Movie movie) {

     return SliverAppBar(
       elevation: 2.0,
       backgroundColor: Colors.indigoAccent,
       expandedHeight: 200.0,
       floating: false,
       pinned: true,
       flexibleSpace: FlexibleSpaceBar(
         centerTitle: true,
         title: Text( 
           movie.title,
           style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage( movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
       ),
     );

  }

  Widget _posterTitle(Movie movie, BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
              image: NetworkImage( movie.getPosterimg() ),
              height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                Text(movie.originalTitle,style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,

      ),
    );

  }

  Widget _createCasting(Movie movie) {

    final movieProvider = new MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if( snapshot.hasData ) {
          return _createCastPageView( snapshot.data );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _createCastPageView(List<Cast> casting) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: casting.length,
        itemBuilder: ( contex, i ) => _castingCard( casting[i] ),
      ),
    );


  }

  Widget _castingCard( Cast cast) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
              image: NetworkImage( cast.getPhoto() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text( 
            cast.name,
            overflow: TextOverflow.ellipsis, 
          ),
        ],
      ),
    );

  }
}