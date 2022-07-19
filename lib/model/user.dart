class User {
  final String username;
  final String email;
  final int admissionYear;
  final String major;
  final String uid;

  const User({
    required this.username,
    required this.email,
    required this.admissionYear,
    required this.major,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "admissionYear": admissionYear,
        "major": major,
        "uid": uid,
      };
}
