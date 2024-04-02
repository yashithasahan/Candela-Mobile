class MembershipModel {
  final String? id;
  final int? membershipLevel;
  final int? membershipCost;
  final DateTime? trialEndDate;
  final DateTime? paymentDate;
  final DateTime? expiryDate;
  final bool? isTrail;
  final bool? isLogin;

  MembershipModel(
      {this.id,
      this.membershipLevel,
      this.membershipCost,
      this.trialEndDate,
      this.paymentDate,
      this.expiryDate,
      this.isTrail,
      this.isLogin
      });

  Map<String, dynamic> toJson() {
    return {
      'membershipLevel': membershipLevel,
      'membershipCost': membershipCost,
      'trialEndDate': trialEndDate,
      'paymentDate': paymentDate,
      'expiryDate': expiryDate,
      'isTrail': isTrail,
      'isLogin': isLogin
    };
  }

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      membershipLevel: json['membershipLevel'],
      membershipCost: json['membershipCost'],
      trialEndDate: (json['trialEndDate']).toDate(),
      paymentDate: (json['paymentDate']).toDate(),
      expiryDate: (json['expiryDate']).toDate(),
      isTrail: json['isTrail'],
      isLogin: json['isLogin'],
    );
  }
}
