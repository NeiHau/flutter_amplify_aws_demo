class CryptoData {
  final String name;
  final double rate;

  CryptoData({required this.name, required this.rate});

  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
      name: json['name'],
      rate: json['rate'],
    );
  }
}
