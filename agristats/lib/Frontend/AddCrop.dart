import 'package:agristats/Backend/App.dart';
import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Common/Components.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddCrop extends StatefulWidget{
  final Crop? crop;
  const AddCrop({super.key,this.crop});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop>{
  final cropName = TextEditingController();
  final plantingDate = TextEditingController();
  final duration = TextEditingController();
  final land = TextEditingController();
  final fertilizerType = TextEditingController();
  final fertilizerAmount = TextEditingController();
  final fertilizerApplicationFrequency = TextEditingController();
  final herbicideType = TextEditingController();
  final herbicideAmount = TextEditingController();
  final herbicideApplicationFrequency = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.crop !=null){
      final currentCrop = widget.crop;
      cropName.text = currentCrop!.cropName;
      plantingDate.text = currentCrop.plantingDate;
      duration.text = currentCrop.duration;
      land.text = currentCrop.landOccupied;
      fertilizerType.text = currentCrop.fertilizerType;
      fertilizerAmount.text = currentCrop.fertilizerAmount;
      fertilizerApplicationFrequency.text = currentCrop.fertilizerFrequency;
      herbicideType.text = currentCrop.herbicideType;
      herbicideAmount.text = currentCrop.herbicideAmount;
      herbicideApplicationFrequency.text = currentCrop.herbicideFrequency;
    }
  }

  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
    setState(() {
      loading = false;
    });
  }

  final saveText = const Text(
    "Save",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  final saveToPDF = const Text(
    "Save to PDF",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  List<String> generateDates(int weekInterval,int totalDuration){
    List<String> dates = [];

    DateTime current = DateTime.now();
    while(current.isBefore(DateTime.now().add(Duration(days: (totalDuration-1)*7)))){
      current = current.add(Duration(days: weekInterval*7));
      dates.add(DateFormat('dd-MM-yyyy').format(current).toString());
    }

    return dates;
  }

  void uploadCropDetails(){
    setState(() {
      loading = true;
    });

    if(cropName.text.isNotEmpty && plantingDate.text.isNotEmpty && duration.text.isNotEmpty && land.text.isNotEmpty && fertilizerType.text.isNotEmpty && fertilizerAmount.text.isNotEmpty && fertilizerApplicationFrequency.text.isNotEmpty && herbicideType.text.isNotEmpty && herbicideAmount.text.isNotEmpty && herbicideApplicationFrequency.text.isNotEmpty){
      final crop = Crop(cropName: cropName.text, plantingDate: plantingDate.text, duration: duration.text, landOccupied: land.text, fertilizerAmount: fertilizerAmount.text, fertilizerType: fertilizerType.text, fertilizerFrequency: fertilizerApplicationFrequency.text, herbicideAmount: herbicideAmount.text, herbicideType: herbicideType.text, herbicideFrequency: herbicideApplicationFrequency.text,herbicideApplicationDates: generateDates(int.parse(herbicideApplicationFrequency.text),int.parse(duration.text)),fertilizerApplicationDates: generateDates(int.parse(fertilizerApplicationFrequency.text),int.parse(duration.text)));
      FirebaseBackend.addCrop(crop, (){
        setState(() {
          loading = false;

        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff255A6B),
          content: Text(
            "${cropName.text} has been successfully added.",
            style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontFamily: "Times"
            ),
          ),
        ));

        Navigator.pop(context);
      });
    }else{
      showErrorObj("Ensure that all fields are filled");
    }
  }

  Widget header(String heading){
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
                // color: Colors.white
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

  void showCalendar(){
    // print(DateTime.now().year);
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
              backgroundColor: const Color(0xff1b424e),
              surfaceTintColor: const Color(0xff1b424e),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DatePicker(
                    minDate: DateTime(DateTime.now().year,DateTime.now().month - 1,1),
                    maxDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                    currentDateTextStyle: const TextStyle(fontFamily: "Times",color: Color(0xff6B8D01),fontSize: 22),
                    currentDateDecoration: BoxDecoration(border: Border.all(color: const Color(0xff6B8D01)),shape: BoxShape.circle),
                    selectedCellDecoration: const BoxDecoration(color: Color(0xff6B8D01),shape: BoxShape.circle),
                    slidersColor: const Color(0xff6B8D01),
                    leadingDateTextStyle: const TextStyle(fontFamily: "Times",color: Color(0xff6B8D01),fontSize: 20),
                    daysOfTheWeekTextStyle: const TextStyle(fontFamily: "Times",color: Colors.white),
                    enabledCellsTextStyle: const TextStyle(fontFamily: "Times",color: Colors.white,fontSize: 17),
                    initialDate: plantingDate.text.isNotEmpty? DateFormat('dd-MM-yyyy').parse(plantingDate.text): DateTime.now(),
                    selectedDate: plantingDate.text.isNotEmpty? DateFormat('dd-MM-yyyy').parse(plantingDate.text) : null,
                    onDateSelected: (val){
                      setState(() {
                        var selected = DateFormat('dd-MM-yyyy').format(val).toString();
                        plantingDate.text = selected;

                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              )
          );
        }
    );
  }

  void convertToPDF()async{
    setState(() {
      loading = true;
    });

    await widget.crop!.generatePdfReport().then((val){
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    final button = Container(
      padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
      width: double.infinity,
      height: 75,
      child: ElevatedButton(
          onPressed: (){
            widget.crop==null ? uploadCropDetails() : convertToPDF();
          },
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: const Color(0xff6B8D01),
          ),
          child: loading ? loadingAnimation : widget.crop!=null ? saveToPDF : saveText
      ),
    );

    final calendar = IconButton(
        onPressed: ()async{
          showCalendar();
        },
        icon: const Icon(
          Icons.calendar_month_outlined,
          // color: Colors.white,
        )
    );

    final appBar = AppBar(
      // backgroundColor: const Color(0xff255A6B),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          // color: Colors.white,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        widget.crop == null ?"Add a crop" : "Crop report",
        style: const TextStyle(
            fontSize: 18,
            // color: Colors.white,
            fontFamily: "Times"
        ),
      ),
    );

    final inputFields = Column(
      children: [
        Input(label: "CROP NAME", editor: cropName, type: TextInputType.text,action: TextInputAction.next,enabled: widget.crop==null,),
        Input(label: "PLANTING DATE", editor: plantingDate, type: TextInputType.none,action: TextInputAction.next,icon: calendar,enabled: widget.crop==null,),
        Input(label: "DURATION TO HARVEST(weeks)", editor: duration, type: TextInputType.number,action: TextInputAction.next,enabled: widget.crop==null,),
        Input(label: "LAND OCCUPIED(Acres)", editor: land, type: TextInputType.number,action: TextInputAction.next,enabled: widget.crop==null,),
        header("FERTILIZER"),
        Row(
          children: [
            Expanded(
              child: Input(label: "TYPE", editor: fertilizerType, type: TextInputType.text,action: TextInputAction.next,enabled: widget.crop==null,),
            ),
            Expanded(
              child: Input(label: "AMOUNT(kg)", editor: fertilizerAmount, type: TextInputType.number,action: TextInputAction.next,enabled: widget.crop==null,),
            )

          ],
        ),
        Input(label: "FREQUENCY (days per week)", editor: fertilizerApplicationFrequency, type: TextInputType.number,action: TextInputAction.next,enabled: widget.crop==null,),
        header("HERBICIDE"),
        Row(
          children: [
            Expanded(
              child: Input(label: "TYPE", editor: herbicideType, type: TextInputType.text,action: TextInputAction.next,enabled: widget.crop==null,),
            ),
            Expanded(
              child: Input(label: "AMOUNT(kg)", editor: herbicideAmount, type: TextInputType.number,action: TextInputAction.next,enabled: widget.crop==null,),
            )

          ],
        ),
        Input(label: "FREQUENCY (weeks)", editor: herbicideApplicationFrequency, type: TextInputType.number,action: TextInputAction.next,enabled: widget.crop==null,),
        button
        // widget.crop == null ? button : const SizedBox(height: 10,),
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
                  image: AssetImage("images/multicrops.png"),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              )
          ),
        ),
        inputFields
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(right: 0,left: 0),
        width: double.infinity,
        height: double.infinity,
        // color: const Color(0xff1b424e),
        child: SingleChildScrollView(
          child: window,
        ),
      ),
    );
  }
}