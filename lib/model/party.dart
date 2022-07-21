import 'package:cloud_firestore/cloud_firestore.dart';

class Party {
  final String partytitle;
  //final DateTime datetime;
  final String place;
  final String info;
  final String uid;
  final String author;
  final List partymember;

  Party({
    required this.partytitle,
    //required this.datetime,
    required this.place,
    required this.info,
    required this.uid,
    required this.author,
    required this.partymember,
  });

  Party.fromMap(
    Map<String, dynamic> map,
  )   : partytitle = map['partytitle'],
        //datetime = DateTime.parse(map['datetime']),
        place = map['place'],
        info = map['info'],
        uid = map['uid'],
        author = map['author'],
        partymember = map['partymember'];

  static Party fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Party(
      partytitle: snapshot["partytitle"],
      place: snapshot["place"],
      info: snapshot["info"],
      uid: snapshot['uid'],
      author: snapshot['author'],
      partymember: snapshot["partymember"],
    );
  }

  Party fromJson(Map<String, dynamic> json) => Party(
      partytitle: json['partytitle'],
      place: json['place'],
      info: json['age'],
      uid: json['uid'],
      author: json['author'],
      partymember: json['partymember']);

  Map<String, dynamic> toJson() => {
        "partytitle": partytitle,
        //"datetime": datetime,
        "place": place,
        "info": info,
        "uid": uid,
        "partymember": partymember,
      };

  @override
  String toString() => "Party<$partytitle>";
}
