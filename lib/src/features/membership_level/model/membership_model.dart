class MembershipModel {
  final String? id;
  final int? membershipLevel;
  final int? membershipCost;
  final DateTime? paymentDate;
  final DateTime? expiryDate;

  MembershipModel(
      {this.id,
      this.membershipLevel,
      this.membershipCost,
      this.paymentDate,
      this.expiryDate});

  Map<String, dynamic> toJson() {
    return {
      'membershipLevel': membershipLevel,
      'membershipCost': membershipCost,
      'paymentDate': paymentDate,
      'expiryDate': expiryDate
    };
  }

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      membershipLevel: json['membershipLevel'],
      membershipCost: json['membershipCost'],
      paymentDate: (json['paymentDate']).toDate(),
      expiryDate: (json['expiryDate']).toDate(),
    );
  }
}
