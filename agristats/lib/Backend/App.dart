import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class MyAppThemes {
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xffB4E1EF),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(color: Color(0xff2CB0DA)),
    scaffoldBackgroundColor: const Color(0xffE8F3F6),
    dividerTheme: const DividerThemeData(
      color: Colors.black
    ),
    drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xff2CB0DA),
        surfaceTintColor: Color(0xff2CB0DA),
        elevation: 5
    ),
    listTileTheme: ListTileThemeData(
        tileColor: const Color(0xffB4E1EF),
        iconColor: Colors.black,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
    ),
    cardTheme: const CardTheme(
        color: Color(0xffB4E1EF),
        surfaceTintColor: Color(0xffB4E1EF)
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          height: 0.9,
          fontFamily: "Times",
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.normal
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Colors.black,
              width: 2
          )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Colors.black,
              width: 2
          )
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Colors.black,
              width: 2
          )
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red,width: 2)
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red,width: 2)
      ),
    ),
    iconTheme: const IconThemeData(
        color: Colors.black
    )
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color(0xff1b424e),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(color: Color(0xff255A6B)),
    scaffoldBackgroundColor: const Color(0xff1b424e),
      dividerTheme: const DividerThemeData(
          color: Colors.white
      ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xff255A6B),
      surfaceTintColor: Color(0xff255A6B),
      elevation: 5
    ),
    listTileTheme: ListTileThemeData(
      tileColor: const Color(0xff1b424e),
      iconColor: Colors.white,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
    ),
    cardTheme: const CardTheme(
      color: Color(0xff1b424e),
      surfaceTintColor: Color(0xff1b424e)
    ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
            height: 0.9,
            fontFamily: "Times",
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.normal
        ),
      ),
    inputDecorationTheme: const InputDecorationTheme(
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.white,
              width: 2
          )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.white,
              width: 2
          )
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.white,
              width: 2
          )
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red,width: 2)
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red,width: 2)
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white
    )
  );
}

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

  void generatePdfReport() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Farmer Report', style: pw.TextStyle(
                  fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Crop             : $cropName'),
              pw.Text('Planting Date    : $plantingDate'),
              pw.Text('Planting Duration: $duration weeks'),
              pw.Text('Area Occupied    : $landOccupied Acres'),
              pw.Text('Planting Duration: $duration weeks'),
              pw.Text('Fertilizer Type  : $fertilizerType'),
              pw.Text('Fertilizer Amount: $fertilizerAmount'),
              pw.Text('Fertilizer Application: $fertilizerFrequency'),
              pw.Text('Herbicide Type    : $herbicideAmount'),
              pw.Text('Herbicide Amount  : $herbicideAmount'),
              pw.Text('Herbicide Application: $herbicideFrequency'),
            ],
          );
        },
      ),
    );
  }
}