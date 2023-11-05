class UserData {
  String nomeUsuario;
  String email;
  String password;

  UserData({
    required this.nomeUsuario,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomeUsuario': nomeUsuario,
      'email': email,
      'senha': password,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      nomeUsuario: map['nomeUsuario'],
      email: map['email'],
      password: map['senha'],
    );
  }

  toJson() {}
}

