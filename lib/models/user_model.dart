class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;

  UserModel({this.uid, this.email, this.name, this.phone});

  //retrieve data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone']
    );
  }

  //post data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone
    };
  }
}