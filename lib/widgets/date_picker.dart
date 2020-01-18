import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clevercheckin/utils/utils.dart';
import 'package:clevercheckin/widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
enum availableState { Available, Unavailable }
final _formKey = GlobalKey<FormState>();


class CalendarProvider extends StatelessWidget {
  final bookedDateSet, priceMap, isSelectable;

  CalendarProvider(this.bookedDateSet,this.priceMap, this.isSelectable);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => PriceAvailabilityProvider(priceMap, bookedDateSet),
      child: DatePicker(isSelectable: isSelectable,defaultStart: DateTime.now() ,weekDayPrice: 8000, weekEndPrice: 10000,),
    );
  }
}

class DatePicker extends StatefulWidget {
  final DateTime defaultStart;
  final int weekDayPrice, weekEndPrice;
  final bool isSelectable;
  availableState _curState;
  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String selectedDate;

  List<List<DateTime>> dates;
  Widget calendar;
  ///Generating DateTime objects for a year since defaultStart
  DatePicker(
      {this.isSelectable,
      this.defaultStart,
      this.weekDayPrice,
      this.weekEndPrice,}) {
    dates = List<List<DateTime>>();
    DateTime temp, anotherTemp;
    int count = 0;
    temp = anotherTemp = defaultStart;
    dates.add(List<DateTime>());
    ///For loop iterating for a year from start date
    for (int i = 0; i < 365; i++) {
      ///Generating and adding DateTime objects to [dates]
      temp = DateTime.utc(
          defaultStart.year, defaultStart.month, defaultStart.day + i);
      if (temp.month != anotherTemp.month) {
        dates.add(List<DateTime>());
        count++;
      }
      dates[count].add(temp);
      anotherTemp = temp;
    }
  }

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController _priceInputController = TextEditingController();

  ///Calendar layout
  @override
  Widget build(BuildContext context) {
    widget.calendar = buildCalendar();
    return Material(
      color: backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: ccGradientDefault),
            ),
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RawMaterialButton(
                            padding: EdgeInsets.all(16.0),
                            constraints:
                            BoxConstraints(minHeight: 10.0, minWidth: 10.0),
                            onPressed: () {Navigator.pop(context);},
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              semanticLabel: 'Back',
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          Visibility(
                            visible: widget.selectedDate == null ? false : true,
                            child: Text(widget.selectedDate == null ? 'No date selected' : '1 date selected', style: Styles.regularLightTextStyle,),
                          ),
                          Visibility(
                            visible: widget.isSelectable ? true : false,
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  widget.selectedDate = null;
                                });
                              },
                              child: Text(
                                'Clear',
                                style: Styles.regularLightTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
                        child: DefaultTextStyle(
                          style: Styles.smallLightTypeTextStyle,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                child: Text('Mon'),
                                width: 32,
                              ),
                              SizedBox(
                                child: Text('Tue'),
                                width: 32,
                              ),
                              SizedBox(
                                child: Text('Wed'),
                                width: 32,
                              ),
                              SizedBox(
                                child: Text('Thu'),
                                width: 32,
                              ),
                              SizedBox(
                                child: Text('Fri'),
                                width: 32,
                              ),
                              SizedBox(
                                child: Text('Sat'),
                                width: 32,
                              ),
                              SizedBox(
                                child: Text('Sun'),
                                width: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    widget.calendar,
                  ]),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isSelectable ? true : false,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: ccGradientPrimary,
                ),
              ),
              height: kBottomNavigationBarHeight,
              child: FlatButton(
                child: Center(child: Text('Edit availability', style: Styles.regularLightTextStyle,)),
                ///Builds the bottomSheet
                onPressed: () {
                  if(widget.selectedDate == null)
                    Fluttertoast.showToast(msg: 'Please select a date !',toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,);
                  else {
                    setState (() {
                      widget._curState =
                      Provider.of<PriceAvailabilityProvider>(context).getAlreadyBookedDates().contains (widget.selectedDate)
                          ? availableState.Unavailable
                          : availableState.Available;
                    });
                    buildBottomSheet (context, widget.selectedDate, widget._curState);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Function to generate the scrollable calendar
  Widget buildCalendar() {
    var rows = List<Widget>();
    var monthColumns = List<List<List<Widget>>>();
    int lastElemIndex = widget.defaultStart.weekday - 1;
    int noOfRows = 0;
    for (int i = 0; i < widget.dates.length; i++) {
      rows.add(Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
        child: Text(
          '${widget.months[((widget.defaultStart.month - 1) + i) % 12]} ${widget.dates[i][0].year}',
          style: Styles.boldDarkTitleTextStyle,
        ),
      ));
      var itr = widget.dates[i].iterator;
      monthColumns.add(List<List<Widget>>());
      noOfRows = (widget.dates[i].length + lastElemIndex) ~/ 7;
      for (int j = 0; j <= noOfRows; j++) {
        monthColumns[i].add(List<Widget>());
        if (j == 0) {
          for (int a = 0; a < lastElemIndex; a++) {
            monthColumns[i][j].add(SizedBox(
              width: 32,
            ));
          }
        }
        while (monthColumns[i][j].length < 7 && itr.moveNext()) {
          monthColumns[i][j].add(buildCalendarCell(date: itr.current, weekDay: monthColumns[i][j].length < 5));
          lastElemIndex = (lastElemIndex + 1) % 7;
        }
        while (monthColumns[i][j].length < 7) {
          monthColumns[i][j].add(SizedBox(
            width: 32,
          ));
        }
        rows.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: monthColumns[i][j],
          ),
        ));
      }
    }
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      ),
    );
  }

  ///BottomSheet Builder
  buildBottomSheet(BuildContext context, String date, availableState availability) {
    var valueProvider = Provider.of<PriceAvailabilityProvider>(context, listen: false);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (BuildContext context) {
          return Provider.value(value: valueProvider, child: StatefulBuilder (
              builder: (BuildContext context, StateSetter state) {
                return Container (
                  child: Column (
                    children: <Widget>[
                      Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RawMaterialButton (
                            padding: EdgeInsets.all (16.0),
                            constraints: BoxConstraints (
                                minHeight: kToolbarHeight, minWidth: 32.0),
                            onPressed: () {
                              Navigator.pop (context);
                            },
                            child: Icon (
                              Icons.clear,
                              color: Colors.black,
                              semanticLabel: 'Back',
                            ),
                          ),
                        ],
                      ),
                      Expanded (
                        child: CustomScrollView (
                          shrinkWrap: true,
                          slivers: <Widget>[
                            SliverList (
                              delegate: SliverChildListDelegate ([
                                Padding (
                                  padding: const EdgeInsets.fromLTRB(
                                      24, 16, 24, 8),
                                  child: Text ('$date',
                                    style: Styles.regularDarkTitleTextStyle,),
                                ),
                                Container (
                                  child: Form(
                                    key: _formKey,
                                    child: Column (
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        Padding (
                                          padding: const EdgeInsets.fromLTRB(
                                              24, 8, 24, 8),
                                          child: Text ('Availability',
                                            style: Styles.regularDarkTextStyle,),
                                        ),
                                        ListTile (
                                          contentPadding: EdgeInsets.fromLTRB (
                                              24, 8, 24, 8),
                                          title: TextFormField (
                                            validator: (value) {
                                              //TODO: Change validator logic
                                              if(!value.isEmpty && int.tryParse(value) <= 0)
                                                return 'Please enter valid price';
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: _priceInputController,
                                            autofocus: true,
                                            decoration: InputDecoration (
                                              prefixText: '\u20B9',
                                              prefixStyle: Styles.subTextStyle.apply(fontSizeFactor: 1.25),
                                              border: InputBorder.none,
                                              hintText: 'Enter price (${Provider.of<PriceAvailabilityProvider>(context).getPrices()[date] ?? widget.weekDayPrice})',
                                              hintStyle: Styles.subTextStyle
                                                  .apply (fontSizeFactor: 1.25),
                                            ),
                                          ),
                                          subtitle: Text ('Price per night',
                                            style: Styles.subTextStyle,),),
                                        RadioListTile<availableState> (
                                          title: Text ('Available',
                                              style: Styles.regularDarkTextStyle),
                                          value: availableState.Available,
                                          groupValue: availability,
                                          onChanged: (availableState value) {
                                            state (() {
                                              availability = value;
                                            });
                                          },),
                                        RadioListTile<availableState> (
                                          title: Text ('Blocked',
                                              style: Styles.regularDarkTextStyle),
                                          value: availableState.Unavailable,
                                          groupValue: availability,
                                          onChanged: (availableState value) {
                                            state (() {
                                              availability = value;
                                            });
                                          },),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Container (
                        height: kBottomNavigationBarHeight,
                        child: FlatButton (
                          child: Center (
                            child: Text ('Save', style: Styles
                                .regularLightTextStyle),
                          ),
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              if(_priceInputController.text.toString() != "") {
                                Provider.of<PriceAvailabilityProvider> (context)
                                    .setPrices (date,
                                    int.parse (_priceInputController.text));
                              }
                              if(availability == availableState.Unavailable) {
                                Provider.of<PriceAvailabilityProvider>(context).blockDate(date);
                              } else {
                                Provider.of<PriceAvailabilityProvider>(context).unblockDate(date);
                              }
                              _priceInputController.clear();
                              Navigator.pop (context);
                            }
                          },
                        ),
                        decoration: BoxDecoration (
                          gradient: LinearGradient (
                            colors: ccGradientPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),);
        }
    );
  }

  ///Function to build calendar cells using DateTime objects
  Widget buildCalendarCell({DateTime date, bool weekDay}) {
    TextStyle cellTextStyle = Styles.regularDarkTextStyle;
    Color cellBackgroundColor = backgroundColor;
    var actualDate = date.toString().substring(0,10);
    if (widget.selectedDate == actualDate) {
      cellTextStyle = Styles.regularLightTextStyle;
      cellBackgroundColor = Colors.lightBlueAccent;
    }
    if (Provider.of<PriceAvailabilityProvider>(context).getAlreadyBookedDates().contains(actualDate) &&
        !widget.isSelectable)
      cellTextStyle = Styles.regularDarkTextStyle.apply(
          color: Colors.black38, decoration: TextDecoration.lineThrough);
    else if(Provider.of<PriceAvailabilityProvider>(context).getAlreadyBookedDates().contains(actualDate) &&
        widget.isSelectable)
      cellTextStyle = Styles.regularDarkTextStyle.apply(
          color: Colors.black, decoration: TextDecoration.lineThrough);
    return GestureDetector(
      onTap: () {
        if (widget.isSelectable) {
          setState(() {
            if(widget.selectedDate == actualDate)
              widget.selectedDate = null;
            else
              widget.selectedDate = actualDate;
          });
        }
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: cellBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Text(
                    date.day.toString(),
                    style: cellTextStyle,
                  )),
            ),
            Container(
              alignment: Alignment(0, 1.5),
              child: GradientText( Provider.of<PriceAvailabilityProvider>(context).getPrices()[actualDate] == null ?
              (weekDay ? '\u20B9${widget.weekDayPrice}' : '\u20B9${widget.weekEndPrice}') : '\u20B9${Provider.of<PriceAvailabilityProvider>(context).getPrices()[actualDate]}',
                  gradient: LinearGradient(
                      colors: Provider.of<PriceAvailabilityProvider>(context).getPrices()[actualDate] == null && weekDay
                          ? ccGradientDefault
                          : ccGradientPrimary),
                  style: Styles.overlayTextStyle),
            ),
          ]),
    );
  }

  @override
  void dispose() {
    if(_priceInputController != null)
      _priceInputController.dispose();
    super.dispose();
  }
}