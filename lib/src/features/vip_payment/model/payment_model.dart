class PaymentModel {
  final String? id;
  final String? userId;
  final int? vipPayment;
  final int? tipPayment;
  final int? totalPayment;
  final DateTime? paymentDate;
  final int? totalSongs;
  final String? duration;


  PaymentModel(
      {this.id,
      this.userId,
      this.vipPayment,
      this.tipPayment,
      this.totalPayment,
      this.paymentDate,
      this.totalSongs,
      this.duration});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'vipPayment': vipPayment,
      'tipPayment': tipPayment,
      'totalPayment': totalPayment,
      'paymentDate': paymentDate,
      'totalSongs': totalSongs,
      'duration': duration
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      userId: json['userId'],
      vipPayment: json['vipPayment'],
      tipPayment: json['tipPayment'],
      totalPayment: json['totalPayment'],
      paymentDate: (json['paymentDate']).toDate(),
      totalSongs: json['totalSongs'],
      duration: json['duration'],
    );
  }
}
