class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Cast.fromJsonMap(Map<String, dynamic> json ) {

    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];


  }

  getPhoto() {
    if ( profilePath == null ) {
      return 'https://www.pinpng.com/pngs/m/341-3415688_no-avatar-png-transparent-png.png';
      
    } else {
        return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}

class MovieCast {

  List<Cast> cast = new List();

  MovieCast.fromJsonList( List<dynamic> jsonList ){

    if( jsonList == null ) return;

    jsonList.forEach( (item) {

      final actor = Cast.fromJsonMap(item);

      cast.add(actor);
      
    });
  }
}
