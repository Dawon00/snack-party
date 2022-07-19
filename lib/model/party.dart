class Party {
  final String partytitle;
  final DateTime datetime;
  final String place;
  final String info;
  final String uid;

  const Party({
    required this.partytitle,
    required this.datetime,
    required this.place,
    required this.info,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "partytitle": partytitle,
        "datetime": datetime,
        "place": place,
        "info": info,
        "uid": uid,
      };
}
