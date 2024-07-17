import 'dart:io';

import 'package:external_path/external_path.dart';
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
  final List<String> fertilizerApplicationDates;
  final String herbicideType;
  final String herbicideAmount;
  final String herbicideFrequency;
  final List<String> herbicideApplicationDates;
  const Crop({required this.cropName,required this.plantingDate,required this.duration,required this.landOccupied,required this.fertilizerAmount,required this.fertilizerType,required this.fertilizerFrequency,required this.herbicideAmount,required this.herbicideType,required this.herbicideFrequency,required this.fertilizerApplicationDates,required this.herbicideApplicationDates});

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

  List<String> getFertilizerApplicationDates(){
    return fertilizerApplicationDates;
  }

  List<String> getHerbicideApplicationDates(){
    return herbicideApplicationDates;
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

  Future<void> generatePdfReport() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                width: double.infinity,
                padding: const pw.EdgeInsets.all(0),
                child: pw.Text('Farmer Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))
              ),
              pw.Divider(thickness: 2,indent: 20,endIndent: 20),
              pw.SizedBox(height: 20),
              pw.Text('Crop             : $cropName',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Planting Date    : $plantingDate',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Planting Duration: $duration weeks',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Area Occupied    : $landOccupied Acres',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Planting Duration: $duration weeks',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Fertilizer Type  : $fertilizerType',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Fertilizer Amount: $fertilizerAmount',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Fertilizer Application: $fertilizerFrequency',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Herbicide Type    : $herbicideAmount',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Herbicide Amount  : $herbicideAmount',style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Herbicide Application: $herbicideFrequency',style: const pw.TextStyle(fontSize: 18)),
            ],
          );
        },
      ),
    );

    final file = File("${await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)}/$cropName-$plantingDate.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}