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
}