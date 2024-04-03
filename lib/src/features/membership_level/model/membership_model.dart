class MembershipModel {
  final String? id;
  final int? membershipLevel;
  final int? membershipCost;
  final DateTime? trialEndDate;
  final DateTime? paymentDate;
  final DateTime? expiryDate;
  final String? status;

  MembershipModel(
      {this.id,
      this.membershipLevel,
      this.membershipCost,
      this.trialEndDate,
      this.paymentDate,
      this.expiryDate,
      this.status});

  Map<String, dynamic> toJson() {
    return {
      'membershipLevel': membershipLevel,
      'membershipCost': membershipCost,
      'trialEndDate': trialEndDate,
      'paymentDate': paymentDate,
      'expiryDate': expiryDate,
      'status': status
    };
  }

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
        membershipLevel: json['membershipLevel'],
        membershipCost: json['membershipCost'],
        trialEndDate: (json['trialEndDate']).toDate(),
        paymentDate: (json['paymentDate']).toDate(),
        expiryDate: (json['expiryDate']).toDate(),
        status: json['status']);
  }
}
