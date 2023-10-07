class Weather_Model {
  Map location;
  Map current;
  Map forecast;

  Weather_Model({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory Weather_Model.fromJSON({required Map data}) {
    return Weather_Model(
      location: data['location'],
      current: data['current'],
      forecast: data['forecast'],
    );
  }
}
