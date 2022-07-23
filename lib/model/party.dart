import 'package:cloud_firestore/cloud_firestore.dart';

class Party {
  final String partytitle;
  final DateTime datetime;
  final String place;
  final String info;
  final String id;
  final String author;
  final List partymember;

  Party({
    required this.partytitle,
    required this.datetime,
    required this.place,
    required this.info,
    this.id = '',
    required this.author,
    required this.partymember,
  });

  Party.fromMap(
    Map<String, dynamic> map,
  )   : partytitle = map['partytitle'],
        datetime = DateTime.parse(map['datetime'].toString()),
        place = map['place'],
        info = map['info'],
        id = map['id'],
        author = map['author'],
        partymember = map['partymember'];

  static Party fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Party(
      partytitle: snapshot["partytitle"],
      datetime: snapshot["datetime"].toDate(),
      place: snapshot["place"],
      info: snapshot["info"],
      id: snapshot['id'],
      author: snapshot['author'],
      partymember: snapshot["partymember"],
    );
  }

  Party fromJson(Map<String, dynamic> json) => Party(
      partytitle: json['partytitle'],
      datetime: json['datetime'],
      place: json['place'],
      info: json['age'],
      id: json['id'],
      author: json['author'],
      partymember: json['partymember']);

  Map<String, dynamic> toJson() => {
        "partytitle": partytitle,
        "datetime": datetime,
        "place": place,
        "info": info,
        "id": id,
        "author": author,
        "partymember": partymember,
      };

  @override
  String toString() => "Party<$partytitle>";
}
