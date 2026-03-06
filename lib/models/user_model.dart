class UserModel {
  final int? id;
  final String email;
  final String password;
  final String nama;
  final String noHP;
  // final String role;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.nama,
    required this.noHP,
    // required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'nama': nama,
      'noHP': noHP,
      // 'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      nama: map['nama'],
      noHP: map['noHP'],
      // role: map['role'],
    );
  }
}
