class Weather {
  final double? temp;
  final double? tempFahrenheit;
  final String city;
  final String country;
  final double lat;
  final double lon;
  final bool isDaytime;
  final double humidity;
  final double cloud;
  final String date;

  Weather({
    required this.temp,
    required this.tempFahrenheit,
    required this.city,
    required this.country,
    required this.lat,
    required this.lon,
    required this.isDaytime,
    required this.humidity,
    required this.cloud,
    required this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: (json['current']['temp_c'] as num).toDouble(),
      tempFahrenheit: (json['current']['temp_f'] as num).toDouble(),
      city: json['location']['name'] as String,
      country: json['location']['country'] as String,
      lat: (json['location']['lat'] as num).toDouble(),
      lon: (json['location']['lon'] as num).toDouble(),
      isDaytime: json['current']['is_day'] == 1,
      humidity: (json['current']['humidity'] as num).toDouble(),
      cloud: (json['current']['cloud'] as num).toDouble(),
      date: json['current']['last_updated'] as String,
    );
  }
}
