import 'package:expenses_app/models/combined_model.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  final CombinedModel cModel;
  DateSelector({Key key, this.cModel}) : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class DateWidget extends StatelessWidget {
  final String name;
  final CombinedModel mDate;
  final bool isSelected;
  const DateWidget({
    Key key, 
    this.name, 
    this.mDate, 
    this.isSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.grey[850],
                borderRadius: BorderRadius.circular(25.0)
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(name)
                )
              ),
            ),
          ),
          // SizedBox(height: 5.0),
          Expanded(
            flex: 1,
            child: isSelected 
              ? FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '${mDate.year.toString()}/${mDate.month.toString()}/${mDate.day.toString()}'
                ),
              )
              : Text(''),
          )
        ],
      ),
    );
  }
}

class _DateSelectorState extends State<DateSelector> {
  String selectedDate;
  @override
  void initState() { 
    if(widget.cModel.day == 0){
      widget.cModel.year = DateTime.now().year;
      widget.cModel.month = DateTime.now().month;
      widget.cModel.day = DateTime.now().day;
      selectedDate = 'Hoy';
    } else {
      selectedDate = 'Otro día';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime myDate = DateTime.now();
    
    datePicker(BuildContext context){
      showDatePicker(
        context: context, 
        locale: const Locale ('es', 'ES'),
        initialDate: myDate.subtract(Duration(hours: 24 * 2)), 
        firstDate: myDate.subtract(Duration(hours: 24 * 30)),
        lastDate: myDate.subtract(Duration(hours: 24 * 2)), 
      ).then((value){
        if(value != null){
          setState(() {
            widget.cModel.year = value.year;
            widget.cModel.month = value.month;
            widget.cModel.day = value.day;
          });
        } else {
          setState(() {
            selectedDate = 'Hoy';
          });
        }
      });
    }

    var widgets = <Widget>[];

    Map<String, DateTime> items = {
      'Hoy' : myDate,
      'Ayer' : myDate.subtract(Duration(hours: 24 * 1)),
      'Otro día': myDate
    };

    items.forEach((name, value) { 
      widgets.add(
        GestureDetector(
          onTap: (){
            setState(() {
              selectedDate = name;
              widget.cModel.year = value.year;
              widget.cModel.month = value.month;
              widget.cModel.day = value.day;

              if(name == 'Otro día'){
                datePicker(context);
              }
            });
          },
          child: DateWidget(
            name: name,
            mDate: widget.cModel,
            isSelected: name == selectedDate,
          ),
        )
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.date_range_outlined, size: 35.0),
        Container(
          height: size.height / 8,
          width: size.width / 1.5,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemExtent: 80.0,
            scrollDirection: Axis.horizontal,
            children: widgets,
          ),
        ),
      ],
    );
  }
}