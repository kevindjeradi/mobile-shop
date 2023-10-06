import 'dart:convert';

class Article {
  String nom;
  String image;
  String description;
  String prix;
  String id;
  late String barcode;
  late int quantite;

  Article({
    required this.nom,
    required this.image,
    required this.description,
    required this.prix,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "image": image,
        "description": description,
        "prix": prix,
        "id": id,
      };

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        nom: json["nom"],
        image: json["image"],
        description: json["description"],
        prix: json["prix"],
        id: json["_id"],
      );

  factory Article.parse(String input) {
    final Map<String, dynamic> json = jsonDecode(input);
    return Article(
      nom: json["nom"],
      image: json["image"],
      description: json["description"],
      prix: json["prix"],
      id: json["id"],
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}
