import 'dart:convert';

class User {
  String firstName;
  String lastName;
  String email;
  String id;
  double solde;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
    required this.solde,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "id": id,
        "solde": solde
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      id: json["_id"],
      solde: json["solde"]);

  factory User.parse(String input) {
    final Map<String, dynamic> json = jsonDecode(input);
    return User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        id: json["_id"],
        solde: json["solde"]);
  }

  @override
  String toString() => jsonEncode(toJson());
}
