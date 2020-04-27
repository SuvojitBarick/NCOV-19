import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_app/splash.dart';
import 'package:photo_view/photo_view.dart';

class WorldData extends StatelessWidget {
  static const String fontName = 'Comfortaa';
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
        body:SingleChildScrollView(
          child:Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20),
                margin: EdgeInsets.all(10),
                width: double.maxFinite,
//            height: ,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                    color: Colors.blueGrey[100]),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: 'WORLD',
                          style: TextStyle(fontFamily: fontName,
                              color: Colors.blue, fontSize: 28),
                          children: <TextSpan>[
                            TextSpan(text: ' Stats',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 20),
                            )
                          ]
                      ),
                    ),
//                    InkWell(
//                      onTap: (){
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => WorldMap()));
//                        print('Tapped on India heaT map');
//                      },
//                      child: RichText(
//                        text: TextSpan(
//                            text: 'WORLD heat',
//                            style: TextStyle(fontFamily: WorldData.fontName,
//                                color: Colors.redAccent, fontSize: 20),
//                            children: <TextSpan>[
//                              TextSpan(text: ' Map',
//                                style: TextStyle(
//                                    color: Colors.black38, fontSize: 14),
//                              ),
//                            ]
//                        ),
//                      ),
//                    ),
                    Divider(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            DataCard2('Cases',world['cases'],world['todayCases']),
                            Divider(height: 10,),
                            DataCard2('Deaths',world['deaths'],world['todayDeaths']),
                          ],
                        ),
                        Divider(height: 10,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              DataCard('Recovered',world['recovered']),
                              Divider(height: 10,),
                              DataCard('Active',world['active']),
                            ]
                        ),
                        Divider(height: 10,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              DataCard('Critical',world['critical']),
                              Divider(height: 10,),
                              DataCard('Tests',world['tests']),
                            ]
                        ),
                        Divider(height: 10,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              DataCard('Cases/Million',world['casesPerOneMillion']),
                              Divider(height: 10,),
                              DataCard('Deaths/Million',world['deathsPerOneMillion']),
                            ]
                        ),
                      ],
                    ),
                    Divider(height: 10,),
                    PieChart(),
                    Divider(height: 10,),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(10),
//                  margin: EdgeInsets.all(5),
                      width: double.maxFinite,
                      height: 400,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          color: Colors.blueGrey[300]),
                      child: SingleChildScrollView(scrollDirection: Axis.vertical,
                        child:Column(children: <Widget>[
                          Center(child:Text('Stats of Top 50 Countries',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        DataTable(
                          columnSpacing: 10,
                          dataRowHeight: 35,
                          headingRowHeight: 50,
                          horizontalMargin: 10,
//                        sortColumnIndex: 1,
//                        sortAscending: true,
                          columns: [
                            DataColumn(label: Text('Countries'),),
                            DataColumn(label: Text('Cases'),),
                            DataColumn(label: Text('Deaths'),),
                            DataColumn(label: Text('Recovered'),),
                          ],
                          rows: [
                            for(int i=8;i<=58;i++)
                            DataRow(
                                cells:[
                              DataCell(
                                RichText(
                                text: TextSpan(
                                    text: '${contries[i]}',
                                    style: TextStyle(fontFamily: fontName,
                                        color: Colors.deepPurple),
                                ),
                              ),
                              ),
                              DataCell(RichText(
                                text: TextSpan(
                                  text: '${casescont[i]}\n',
                                  style: TextStyle(fontFamily: fontName,
                                      color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(text: '${newcasecont[i]}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ]
                                ),
                              ),),
                              DataCell(RichText(
                                text: TextSpan(
                                    text: '${deathcont[i]}\n',
                                    style: TextStyle(fontFamily: fontName,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(text: '${newdeathcont[i]}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ]
                                ),
                              ),),
                              DataCell(RichText(
                                text: TextSpan(
                                    text: '${recovercont[i]}',
                                    style: TextStyle(fontFamily: fontName,
                                        color: Colors.black),
//                                    children: <TextSpan>[
//                                      TextSpan(text: '${newcasecont[i]}',
//                                        style: TextStyle(
//                                            color: Colors.black38, fontSize: 8),
//                                      )
//                                    ]
                                ),
                              ),),
                            ])
                          ],
                        ),
                        ],),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),)
    );
  }
}
class GradesData {
  final String gradeSymbol;
  final int number;
  final charts.Color col;

  GradesData(this.gradeSymbol, this.number,this.col);
}

class PieChart extends StatelessWidget {


  final data = [
    GradesData('Active', world['active'],charts.ColorUtil.fromDartColor(Colors.redAccent)),
    GradesData('Recovered', world['recovered'],charts.ColorUtil.fromDartColor(Colors.lightGreen)),
    GradesData('Deaths', world['deaths'],charts.ColorUtil.fromDartColor(Colors.blueGrey)),
  ];

  _getSeriesData() {
    List<charts.Series<GradesData, String>> series = [
      charts.Series(
        id: "Grades",
        data: data,
        labelAccessorFn: (GradesData row, _) => '${row.gradeSymbol}:${row.number}',
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
        height: 300,
        padding: EdgeInsets.all(10),
        child: Card(color: Colors.blueGrey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Total data represented in PIE Chart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
//                  SizedBox(
//                    height: 20,
//                  ),
                Expanded(
                  child: new charts.PieChart(
                    _getSeriesData(),
                    animate: true,
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 200,startAngle: 49,
                        arcRendererDecorators: [new charts.ArcLabelDecorator()]
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class WorldMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NCOV - 19",
            style: TextStyle(
              fontFamily: WorldData.fontName,
              color: Colors.white,
              fontSize: 20.0,
            )),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))),
        elevation: 20,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        height: double.maxFinite,width: double.infinity,
        child: PhotoView(
          enableRotation: false,basePosition: Alignment.center,tightMode: true,
          imageProvider: NetworkImage('https://covid19ind.zaoapp.net/wp-content/uploads/2020/03/Global-Map-1024x672.png',),
          backgroundDecoration: BoxDecoration(color: Colors.white70),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
class DataCard extends StatelessWidget {
  String txt;
  var txtdata;
  DataCard(this.txt,this.txtdata);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      width: 150,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('$txt',style: TextStyle(fontSize: 20,color: Colors.white60),textAlign: TextAlign.center,),
          Text('$txtdata',style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
// ignore: must_be_immutable
class DataCard2 extends StatelessWidget {
  String txt,txt2;
  var txtdata,txt2data;
  DataCard2(this.txt,this.txtdata,this.txt2data);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      width: 150,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('$txt',style: TextStyle(fontSize: 20,color: Colors.white60),textAlign: TextAlign.center,),
          Text('$txtdata',style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
          Text('${txt2data!='0'?'+$txt2data':''}',style: TextStyle(fontSize: 16,color: Colors.redAccent),textAlign: TextAlign.center,),
//          RichText(text:TextSpan(text:'$txtdata',style: TextStyle(fontSize: 20,color: Colors.white),
//            children: <TextSpan>[TextSpan(text:'${txt2data==0?'':' +$txt2data'}',style: TextStyle(fontSize: 15,color: Colors.redAccent),
            ],
          ),
    );
  }
}
