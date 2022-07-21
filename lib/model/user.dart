import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final int admissionYear;
  final String major;
  final String uid;
  final List parties;

  const User({
    required this.username,
    required this.email,
    required this.admissionYear,
    required this.major,
    required this.uid,
    required this.parties,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      email: snapshot["email"],
      admissionYear: snapshot["admissionYear"],
      major: snapshot['major'],
      uid: snapshot["uid"],
      parties: snapshot["parties"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "admissionYear": admissionYear,
        "major": major,
        "uid": uid,
        "parties": parties,
      };
}
