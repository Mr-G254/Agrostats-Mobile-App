import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherAPI{
  static WeatherFactory weather = WeatherFactory("be90de107c2068e9a44de0c9fc4a1d0e");
  static bool serviceIsEnabled = false;
  static Position? position;
  static Weather? currentWeather ;

  static Future<void> initialize()async{
    LocationPermission permission = await Geolocator.requestPermission();
    serviceIsEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceIsEnabled){
      Future.error("Ensure your location is enabled");
    }else{
      await WeatherAPI.getCurrentWeather();
    }
  }

  static Future<void> getCurrentWeather()async{
    position = await Geolocator.getCurrentPosition();
    currentWeather = await weather.currentWeatherByLocation(position!.latitude, position!.longitude);


  }
}