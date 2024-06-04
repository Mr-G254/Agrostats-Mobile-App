import 'dart:ui';
import 'package:agristats/Common/Components.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Crops extends StatefulWidget{
  const Crops({super.key});

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops>{
  final cropName = TextEditingController();
  final plantingDate = TextEditingController();
  final wateringFrequency = TextEditingController();
  final fertilizerType = TextEditingController();
  final fertilizerAmount = TextEditingController();
  final fertilizerApplicationFrequency = TextEditingController();

  Widget header(String heading){
    plantingDate.text = "";

    return Container(
      padding: const EdgeInsets.only(top: 20,right: 30,left: 30),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              heading,
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: "Times",
                  color: Colors.white
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0),
            width: double.infinity,
            height: 5,
            child: const Divider(thickness: 2,),
          )
        ],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context){
    final calendar = IconButton(
        onPressed: ()async{
          showDialog(
            context: context,
            builder: (context){
              return Dialog(
                backgroundColor: const Color(0xff1b424e),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DatePicker(
                      minDate: DateTime(DateTime.now().year),
                      maxDate: DateTime(DateTime.now().year + 1),
                      slidersColor: const Color(0xff6B8D01),
                      leadingDateTextStyle: const TextStyle(fontFamily: "Times",color: Color(0xff6B8D01),fontSize: 20),
                      daysOfTheWeekTextStyle: const TextStyle(fontFamily: "Times",color: Colors.white),
                      enabledCellsTextStyle: const TextStyle(fontFamily: "Times",color: Colors.white,fontSize: 17),
                      initialDate: plantingDate.text.isNotEmpty? DateFormat('dd-MM-yyyy').parse(plantingDate.text): DateTime.now(),
                      selectedDate: plantingDate.text.isNotEmpty? DateFormat('dd-MM-yyyy').parse(plantingDate.text) : null,
                      onDateSelected: (val){
                        setState(() {
                          plantingDate.text = DateFormat('dd-MM-yyyy').format(val).toString();
                          Navigator.pop(context);
                        });
                      },
                    )
                  ],
                )
              );
            }
          );
          // DateTime? selectedDate = await showDatePickerDialog(
          //   context: context,
          //   maxDate: DateTime(DateTime.now().year + 1),
          //   minDate: DateTime(DateTime.now().year),
          //   daysOfTheWeekTextStyle: TextStyle(fontFamily: "Times"),
          //   enabledCellsTextStyle: TextStyle(fontFamily: "Times",fontWeight: FontWeight.bold,fontSize: 20)
          // );

          // DateTime? selectedDate = await
          //
          // if(selectedDate.toString() != "null"){
          //   setState(() {
          //     plantingDate.text = DateFormat('d-MM-yyyy').format(selectedDate!).toString();
          //   });
          // }

        },
        icon: const Icon(Icons.calendar_month_outlined,color: Colors.white,)
    );
    
    final appBar = AppBar(
      backgroundColor: const Color(0xff255A6B),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        "Add a crop",
        style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Times"
        ),
      ),
    );

    final inputFields = Column(
      children: [
        Input(label: "CROP NAME", editor: cropName, type: TextInputType.text,action: TextInputAction.next),
        Input(label: "PLANTING DATE", editor: plantingDate, type: TextInputType.none,action: TextInputAction.next,icon: calendar,),
        Input(label: "WATERING FREQUENCY (days per week)", editor: wateringFrequency, type: TextInputType.text,action: TextInputAction.next),
        header("FERTILIZER"),
        Row(
          children: [
            Expanded(
              child: Input(label: "TYPE", editor: fertilizerType, type: TextInputType.text,action: TextInputAction.next),
            ),
            Expanded(
              child: Input(label: "AMOUNT(g)", editor: fertilizerAmount, type: TextInputType.text,action: TextInputAction.next),
            )

          ],
        ),
        Input(label: "FREQUENCY (days per week)", editor: fertilizerApplicationFrequency, type: TextInputType.visiblePassword,action: TextInputAction.next),

      ],
    );

    final window = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 2.1,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: const Image(
                image: AssetImage("images/crop.jpg"),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            )
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: inputFields,
          )
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(right: 0,left: 0),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1b424e),
        child: window,
      ),
    );
  }
}