class UserModel {
  final String? id;
  final String? fullName;
  final String? address;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? membershipLevel;
  // final String? bankName;
  // final String? bankRoutingNumber;
  // final String? bankAccNumber;
  // final String? photoUrl;
  final String? language;
  final String? songPrice;


  UserModel({
    this.id,
    this.fullName,
    this.address,
    this.email,
    this.userName,
    this.phoneNumber,
    this.membershipLevel,
    // this.bankName,
    // this.bankRoutingNumber,
    // this.bankAccNumber,
    // this.photoUrl,
    this.language,
    this.songPrice,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      address: json['address'],
      email: json['email'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      membershipLevel: json['membershipLevel'],
      // bankName: json['bankName'],
      // bankRoutingNumber: json['bankRoutingNumber'],
      // bankAccNumber: json['bankAccNumber'],
      // photoUrl: json['photoUrl'],
      language: json['language'],
      songPrice: json['songPrice'],
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'address': address,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'membershipLevel': membershipLevel,
      // 'bankName': bankName,
      // 'bankRoutingNumber': bankRoutingNumber,
      // 'bankAccNumber': bankAccNumber,
      // 'photoUrl': photoUrl,
      'language': language,
      'songPrice': songPrice,
    };
  }
}
