class Actors{
  List<Actor> actors = new List();

  Actors();

  Actors.fromJsonList( List<dynamic> jsonList ){
    if( jsonList == null ) return;

    for (var item in jsonList) {
      
      final actor = new Actor.fromJsonMap( item );

      actors.add( actor );
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json){
    castId          = json['cast_id'];
    character       = json['character'];
    creditId        = json['credit_id'];
    gender          = json['gender'];
    id              = json['id'];
    name            = json['name'];
    order           = json['order'];
    profilePath     = json['profile_path'];

  }

  getPhoto(){
    if( profilePath == null ){

      return 'https://appfollow.io/assets/2/img/team/no-avatar.png';
    }
    else {

      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}