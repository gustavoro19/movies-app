import 'package:flutter/material.dart';


import 'package:movies/src/widgets/cart_swiper_widget.dart';

// import 'package:flutter_swiper/flutter_swiper.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies in theaters'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _cardsSwiper(),
          ],
        ),
      ) 
    );
  }

  Widget _cardsSwiper() {

    return CardSwiper(
      movies: [1,2,3,4,5],
    );

  }
}