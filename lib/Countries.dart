import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/splash.dart';
import 'package:http/http.dart';
import 'package:charts_flutter/flutter.dart' as charts;
String newContName;
var data;
var timeline;
var intervals;
bool isLoading = false;
int no;
List<FlSpot> allSpots,allSpots2,allSpots3;
// ignore: must_be_immutable
class CountriesData extends StatefulWidget {
  var newName;
  CountriesData(this.newName){
    newContName = newName;
  }

  @override
  _CountriesDataState createState() => _CountriesDataState();
}

class _CountriesDataState extends State<CountriesData> {
  final String fontName = 'Comfortaa';
//  var isLoading = false;

  var data;
  var allSpots,allSpots2,allSpots3;
  bool moreData = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
//    _getThingsOnStartup().then((value){
      for(int i=0;i<countryData.length;i++)
      {
        if(countryData[i]['country'].toString().toLowerCase().compareTo(newContName.toString().toLowerCase())==0)
          {
            data = fetch(countryData[i]['country']);
            no = i;
            break;
          }
      }
      setState(() {
        data = fetch(countryData[no]['country']);
      });

//    });
  }
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }
//  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NCOV - 19",
            style: TextStyle(
              fontFamily: fontName,
              color: Colors.white,
              fontSize: 20.0,
            )),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))),
        elevation: 20,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.s,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey[100]),
              child: Column(
                children: <Widget>[
                  Container(
//                  height: 200.0,
                    width: double.maxFinite,
                    margin: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                      color: new Color(0xFF333366),
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(10.0),
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: new Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Divider(height: 10,),
                        Image.network(countryData[no]['countryInfo']['flag'],height: 100,width: 150,),
                        Text('${countryData[no]['country']}',
                          style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                        Divider(height: 10,),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Cases:\nRecovered:\nDeaths:\nActive:\nCritical:\n\nYesterday Cases:\nYesterday Deaths:\nCases/Million:\nDeaths/Million:',
                                textAlign: TextAlign.start,softWrap: true,
                                style: TextStyle(fontSize: 20,color: Colors.white70),),

                              Text('${countryData[no]['cases']}'
                                  '\n${countryData[no]['recovered']}\n${countryData[no]['deaths']}'
                                '\n${countryData[no]['active']}\n${countryData[no]['critical']}\n'
                                  '\n+${countryData[no]['todayCases']}\n+${countryData[no]['todayDeaths']}'
                                '\n${countryData[no]['casesPerOneMillion']}\n${countryData[no]['deathsPerOneMillion']}',
                                textAlign: TextAlign.end,softWrap: true,
                                style: TextStyle(fontSize: 20,color: Colors.white70,fontWeight: FontWeight.bold),),

                          ],),
                        ),
                      ],
                    ),
                  ),
                  PieChart(),
                  Divider(height: 10,),
                  isLoading || data==null?Center(child:CircularProgressIndicator()):
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          color: Colors.blueGrey[300]),
//                      height: 250,
                      padding: EdgeInsets.all(10),
                      child:Card(color: Colors.blueGrey[100],
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LineChart2(allSpots,allSpots2,allSpots3,intervals),
                        ),
                      ),

                  ),
                ],
              ),
            ),
          ],),
      ),
    );
  }

  fetch(String countryName) async{
    setState(() {
      isLoading = true;
    });
    final Response resp = await get("https://disease.sh/v2/historical/$countryName?lastdays=all");
    if(resp.statusCode==200){
      var data1 = resp.body;
      data = jsonDecode(data1);
//    print(data);
      timeline = 0;
      int cnt1=0;
      allSpots = [
        for (var i in data['timeline']['cases'].keys)
          FlSpot(double.parse((cnt1++).toString()), double.parse(data['timeline']['cases'][i].toString())),
      ];
      int cnt2=0;
      allSpots2 = [
        for (var i in data['timeline']['cases'].keys)
          FlSpot(double.parse((cnt2++).toString()), double.parse(data['timeline']['recovered'][i].toString())),
      ];
      int cnt3=0;
      allSpots3 = [
        for (var i in data['timeline']['cases'].keys)
          FlSpot(double.parse((cnt3++).toString()), double.parse(data['timeline']['deaths'][i].toString())),
      ];
      intervals = countryData[no]['cases']/4;
      setState(() {
        isLoading = false;
      });
//    print(allSpots3);
      return data;
    }
    else return null;
  }
}


// ignore: must_be_immutable
class LineChart2 extends StatelessWidget {
  @override
  StatelessElement createElement() {
    // TODO: implement createElement
    return super.createElement();
    Future.delayed(Duration(seconds: 5));
  }
  var data;
  var timeline;
  var intervals;
  List<FlSpot> allSpots,allSpots2,allSpots3;
  LineChart2(this.allSpots,this.allSpots2,this.allSpots3,this.intervals);
  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
//          showingIndicators: showIndexes,
        spots: allSpots,
        isCurved: true,
        barWidth: 2,
        shadow: const Shadow(
          blurRadius: 4,
          color: Colors.black,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [Colors.orangeAccent],
        ),
        dotData: FlDotData(
          show: true,
          dotSize: 2,
          strokeWidth: 1,
        ),
      ),
      LineChartBarData(
//        showingIndicators: showIndexes,
        spots: allSpots2,
        isCurved: true,
        barWidth: 2,
        shadow: const Shadow(
          blurRadius: 4,
          color: Colors.black,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [
            Colors.lightGreen
          ],
        ),
        dotData: FlDotData(
          show: false,
          dotSize: 2,
          strokeWidth: 2,
        ),
      ),
      LineChartBarData(
//        showingIndicators: showIndexes,
        spots: allSpots3,
        isCurved: true,
        barWidth: 2,
        shadow: const Shadow(
          blurRadius: 2,
          color: Colors.black,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [
            Colors.purple
          ],
        ),
        dotData: FlDotData(
          show: false,
          dotSize: 2,
          strokeWidth: 2,
        ),
      ),
    ];
//    Future.delayed(Duration(seconds: 10));
    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return Container(
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(15), color: Colors.blueGrey[300]),
//      height: 240,
//      width: 165,
      padding: EdgeInsets.all(8),
      child:Column(
        children: <Widget>[
          Text(
            "Cases Timeline",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
//              Text(
//                "Last 30 days",
//                textAlign: TextAlign.center,
//              ),
          SizedBox(
//                width: 100,
//                height: 100,
            child: LineChart(
              LineChartData(
//                    showingTooltipIndicators: showIndexes.map((index) {
//                      return ShowingTooltipIndicators(index, [
//                        LineBarSpot(
//                            tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar), tooltipsOnBar.spots[index]),
//                      ]);
//                    }).toList(),
                lineTouchData: LineTouchData(
                  enabled: true,
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: Colors.pink,
                        ),
                        FlDotData(
                          show: true,
                          dotSize: 1,
                          strokeWidth: 1,
//                    getStrokeColor: (spot, percent, barData) => Colors.black,
                          getDotColor: (spot, percent, barData) {
                            return lerpGradient(barData.colors,
                                barData.colorStops, percent / 100);
                          },
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.redAccent,
                    tooltipRoundedRadius: 10,
                    getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                      return lineBarsSpot.map((lineBarSpot) {
                        return LineTooltipItem(
                          lineBarSpot.y.toString().split('.')[0],//+':'+lineBarSpot.x.toString().split('.')[0],
//                                  + '  :  ' +
//                                  dates[int.parse(lineBarSpot.x
//                                          .toString()
//                                          .split('.')[0])]
//                                      .toString()
//                                      .substring(1, 3) +
//                                  '/' +
//                                  dates[int.parse(lineBarSpot.x
//                                          .toString()
//                                          .split('.')[0])]
//                                      .toString()
//                                      .substring(0, 1),
                          //lineBarSpot.x.toString().substring(1,3)+'/'+lineBarSpot.x.toString().substring(0,1),
                          const TextStyle(
                              color: Colors.white, fontSize: 10),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: lineBarsData,
                minY: 0, //clipToBorder: true,
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: intervals,rotateAngle: 20,
                      textStyle: TextStyle(
                          fontSize: 10,
                          color: Colors.blueGrey,
                          letterSpacing: -1)),
                  bottomTitles: SideTitles(
                      showTitles: false,
                      interval: dates.length/10,
                      margin: 5,rotateAngle: 90,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontFamily: 'Digital',
                        fontSize: 10,
                      )),
                ),
                axisTitleData: FlAxisTitleData(
                  //            rightTitle: AxisTitle(showTitle: true, titleText: 'count'),
                  //            leftTitle: AxisTitle(showTitle: true, titleText: 'count'),
                  topTitle: AxisTitle(
                      showTitle: false,
                      titleText: '30 day data',
                      textAlign: TextAlign.center),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                  show: false,
                ),
              ),
            ),
          ),
          Divider(height: 10,),
          Container(
            child: Column(children: <Widget>[Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Cases'),
                Icon(Icons.assignment_return,color: Colors.orangeAccent,size: 20,),
                Divider(height: 10,),
                Text('Recovered'),
                Icon(Icons.assignment_return,color: Colors.lightGreen,size: 20,),
                Divider(height: 10,),
                Text('Deaths'),
                Icon(Icons.assignment_return,color: Colors.purple,size: 20,),
              ],
            ),
//              Text('Start Date : '),
//                    Divider(height: 5,),
//                    Text('Cases : Day no.'),
//                    Text('Recovered : Day no.'),
//                    Text('Deaths : Day no.'),
            ],),
          ),
        ],
      )

    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (stops == null || stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / colors.length;
      stops.add(percent * (index + 1));
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT);
    }
  }
  return colors.last;
}
class GradesData {
  final String gradeSymbol;
  final int number;
  final charts.Color col;

  GradesData(this.gradeSymbol, this.number,this.col);
}
class PieChart extends StatelessWidget {


  final data = [
    GradesData('Active',int.parse( (countryData[no]['active']/countryData[no]['cases']*100).toString().split('.')[0]),charts.ColorUtil.fromDartColor(Colors.pinkAccent)),
    GradesData('Recov.', int.parse((countryData[no]['recovered']/countryData[no]['cases']*100).toString().split('.')[0]),charts.ColorUtil.fromDartColor(Colors.lightGreen)),
    GradesData('Deaths',int.parse( (countryData[no]['deaths']/countryData[no]['cases']*100).toString().split('.')[0]),charts.ColorUtil.fromDartColor(Colors.blueGrey)),
  ];

  _getSeriesData() {
    List<charts.Series<GradesData, String>> series = [
      charts.Series(
        id: "Grades",
        data: data,
        labelAccessorFn: (GradesData row, _) => '${row.gradeSymbol}:${row.number}%',
        domainFn: (GradesData grades, _) => grades.gradeSymbol,
        measureFn: (GradesData grades, _) => grades.number,
        colorFn: (GradesData series, _) => series.col,
      )
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
            color: Colors.blueGrey[300]),
        height: 250,
        padding: EdgeInsets.all(10),
        child: Card(color: Colors.blueGrey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Total data represented in PIE Chart",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16,
                      fontWeight: FontWeight.bold,color: Colors.deepOrange

                  ),
                ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  Divider(height: 10,),
                Divider(height: 10,),
                Expanded(
                  child: new charts.PieChart(
                    _getSeriesData(),
                    animate: true,
                    animationDuration: Duration(milliseconds: 800),
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 200,startAngle: 49,
                        arcRendererDecorators: [new charts.ArcLabelDecorator()]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
