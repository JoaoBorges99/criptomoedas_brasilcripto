class CriptoDetails{
  double priceUsd = 0.0;
  DateTime date = DateTime.now();

  CriptoDetails({
    required this.priceUsd,
    required this.date,
  });

  CriptoDetails.fromJson(Map<String,dynamic> json){
    priceUsd = json['priceUsd']?.toDouble() ?? 0.0;
    date = DateTime.parse(json['date'] ?? DateTime.now());
  }

}