class CriptoDetails{
  String priceUsd = '';
  String date = '';

  CriptoDetails({
    required this.priceUsd,
    required this.date,
  });

  CriptoDetails.fromJson(Map<String,dynamic> json){
    priceUsd = json['priceUsd'] ?? 0.0;
    date = json['date'] ?? '';
  }

  double get price => double.tryParse(priceUsd) ?? 0.0;

  // Converte a data no formato 02/04/2025
  String get formattedDate {
    final dt = DateTime.parse(date);
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }
}