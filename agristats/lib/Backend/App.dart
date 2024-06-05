class FarmDetails{
  final String size;
  final String location;
  final String soil;
  const FarmDetails({required this.size,required this.location,required this.soil});

  String getSize(){
    return size;
  }

  String getLocation(){
    return location;
  }

  String getSoil(){
    return soil;
  }

  Map<String, dynamic> toMap(){
    return {
      "size" : size,
      "location" : location,
      "soil" : soil
    };
  }
}

class Crop{
  final String cropName;
  final String plantingDate;
  final String duration;
  final String landOccupied;
  final String fertilizerType;
  final String fertilizerAmount;
  final String fertilizerFrequency;
  final String herbicideType;
  final String herbicideAmount;
  final String herbicideFrequency;
  const Crop({required this.cropName,required this.plantingDate,required this.duration,required this.landOccupied,required this.fertilizerAmount,required this.fertilizerType,required this.fertilizerFrequency,required this.herbicideAmount,required this.herbicideType,required this.herbicideFrequency});

  String getCropName(){
    return cropName;
  }

  String getPlantingDate(){
    return plantingDate;
  }

  String getDuration(){
    return duration;
  }

  String getLandOccupied(){
    return landOccupied;
  }

  String getFertilizerType(){
    return fertilizerType;
  }

  String getFertilizerAmount(){
    return fertilizerAmount;
  }

  String getFertilizerFrequency(){
    return fertilizerFrequency;
  }

  String getHerbicideType(){
    return herbicideType;
  }

  String getHerbicideAmount(){
    return herbicideAmount;
  }

  String getHerbicideFrequency(){
    return herbicideFrequency;
  }

  Map<String, dynamic> toMap(){
    return {
      "name" : cropName,
      "plantingDate" : plantingDate,
      "duration" : duration,
      "landOccupied" : landOccupied,
      "fertilizerType" : fertilizerType,
      "fertilizerAmount" : fertilizerAmount,
      "fertilizerApplicationFrequency" : fertilizerFrequency,
      "herbicideType" : herbicideType,
      "herbicideAmount" : herbicideAmount,
      "herbicideApplicationFrequency" : herbicideFrequency
    };
  }
}