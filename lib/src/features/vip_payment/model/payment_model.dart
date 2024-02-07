class PaymentModel {
  final String? id;
  final String? userId;
  final String? vipPayment;
  final String? tipPayment;
  final String? totalPayment;
  final String? paymentDate;

  PaymentModel(
      {this.id,
      this.userId,
      this.vipPayment,
      this.tipPayment,
      this.totalPayment,
      this.paymentDate});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'vipPayment': vipPayment,
      'tipPayment': tipPayment,
      'totalPayment': totalPayment,
      'paymentDate': paymentDate,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      userId: json['userId'],
      vipPayment: json['vipPayment'],
      tipPayment: json['tipPayment'],
      totalPayment: json['totalPayment'],
      paymentDate: json['paymentDate'],
    );
  }
}
