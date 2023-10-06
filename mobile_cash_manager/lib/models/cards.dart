import 'dart:convert';

class Cards {
  String email;
  String cardNumber;
  String expiryDate;
  String cvvCode;
  String cardHolder;

  Cards({
    required this.email,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvCode,
    required this.cardHolder,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "cardNumber": cardNumber,
        "expiryDate": expiryDate,
        "cvvCode": cvvCode,
        "cardHolder": cardHolder
      };

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        email: json["holderEmail"],
        cardNumber: json["cardNumber"],
        expiryDate: json["expiryDate"],
        cvvCode: json["cvvCode"],
        cardHolder: json["cardHolder"],
      );

  factory Cards.parse(String input) {
    final Map<String, dynamic> json = jsonDecode(input);
    return Cards(
      email: json["holderEmail"],
      cardNumber: json["cardNumber"],
      expiryDate: json["expiryDate"],
      cvvCode: json["cvvCode"],
      cardHolder: json["cardHolder"],
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}
