class User {
  final String username;
  final String password; // sera hashé en base de données

  User({
    required this.username,
    required this.password,
  });

  // Convertir en Map pour stocker en BD
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Créer un User à partir d'une Map 
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
