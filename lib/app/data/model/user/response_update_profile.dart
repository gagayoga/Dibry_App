/// status : 201
/// message : "Profil berhasil diperbarui"
/// data : {"id":2,"email":"flowbook@smk.belajar.id","Username":"Pasyaxexeee","nama_lengkap":"Pasyadcdceee","telepon":"098762345671","bio":"Bismillah aja dulu","level":"User","password":"Password03@"}

class ResponseUpdateProfile {
  ResponseUpdateProfile({
      this.status, 
      this.message, 
      this.data,});

  ResponseUpdateProfile.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataUpdateProfile.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  DataUpdateProfile? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : 2
/// email : "flowbook@smk.belajar.id"
/// Username : "Pasyaxexeee"
/// nama_lengkap : "Pasyadcdceee"
/// telepon : "098762345671"
/// bio : "Bismillah aja dulu"
/// level : "User"
/// password : "Password03@"

class DataUpdateProfile {
  DataUpdateProfile({
      this.id, 
      this.email, 
      this.username, 
      this.namaLengkap, 
      this.telepon, 
      this.bio, 
      this.level, 
      this.password,});

  DataUpdateProfile.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['Username'];
    namaLengkap = json['nama_lengkap'];
    telepon = json['telepon'];
    bio = json['bio'];
    level = json['level'];
    password = json['password'];
  }
  int? id;
  String? email;
  String? username;
  String? namaLengkap;
  String? telepon;
  String? bio;
  String? level;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['Username'] = username;
    map['nama_lengkap'] = namaLengkap;
    map['telepon'] = telepon;
    map['bio'] = bio;
    map['level'] = level;
    map['password'] = password;
    return map;
  }

}