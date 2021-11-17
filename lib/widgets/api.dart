import 'dart:async';
import 'dart:convert';
import '../constant.dart';
import './counter.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.covidtracking.com/v1/us/current.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String date;
  final String states;
  final String positive;
  final String negative;
  final String pending;
  final String hospitalizedCurrently;
  final String hospitalizedCumulative;
  final String inIcuCurrently;
  final String inIcuCumulative;
  final String onVentilatorCurrently;
  final String onVentilatorCumulative;
  final String dateChecked;
  final String death;
  final String hospitalized;
  final String totalTestResults;
  final String lastModified;
  final String recovered;
  final String total;
  final String posNeg;
  final String deathIncrease;
  final String hospitalizedIncrease;
  final String negativeIncrease;
  final String positiveIncrease;
  final String totalTestResultsIncrease;
  final String hash;

  Album({
    this.date,
    this.states,
    this.positive,
    this.negative,
    this.pending,
    this.hospitalizedCurrently,
    this.hospitalizedCumulative,
    this.inIcuCurrently,
    this.inIcuCumulative,
    this.onVentilatorCurrently,
    this.onVentilatorCumulative,
    this.dateChecked,
    this.death,
    this.hospitalized,
    this.totalTestResults,
    this.lastModified,
    this.recovered,
    this.total,
    this.posNeg,
    this.deathIncrease,
    this.hospitalizedIncrease,
    this.negativeIncrease,
    this.positiveIncrease,
    this.totalTestResultsIncrease,
    this.hash,
  });

  factory Album.fromJson(List<dynamic> list) {
    var json = list[0];
    return Album(
      date: json["date"].toString(),
      states: json["states"].toString(),
      positive: json['positive'].toString(),
      negative: json["negative"].toString(),
      pending: json['pending'].toString(),
      hospitalizedCurrently: json['hospitalizedCurrently'].toString(),
      hospitalizedCumulative: json['hospitalizedCumulative'].toString(),
      inIcuCurrently: json['inIcuCurrently'].toString(),
      inIcuCumulative: json['inIcuCumulative'].toString(),
      onVentilatorCurrently: json['onVentilatorCurrently'].toString(),
      onVentilatorCumulative: json['onVentilatorCumulative'].toString(),
      dateChecked: json['dateChecked'].toString(),
      death: json['death'].toString(),
      hospitalized: json['hospitalized'].toString(),
      totalTestResults: json['totalTestResults'].toString(),
      lastModified: json['lastModified'].toString(),
      recovered: json['recovered'].toString(),
      total: json['total'].toString(),
      posNeg: json['posNeg'].toString(),
      deathIncrease: json['deathIncrease'].toString(),
      hospitalizedIncrease: json['hospitalizedIncrease'].toString(),
      negativeIncrease: json['negativeIncrease'].toString(),
      positiveIncrease: json['positiveIncrease'].toString(),
      totalTestResultsIncrease: json['totalTestResultsIncrease'].toString(),
      hash: json['hash'].toString(),
    );
  }
}

class API extends StatefulWidget {
  const API({Key key}) : super(key: key);

  @override
  _APIState createState() => _APIState();
}

class _APIState extends State<API> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  var pos;
  var deaths;
  var recovered;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              pos = snapshot.data.positive;
              deaths = snapshot.data.hospitalized;
              recovered = snapshot.data.inIcuCumulative;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Counter(
                    color: kInfectedColor,
                    number: pos,
                    title: "infected",
                  ),
                  Counter(
                    color: kDeathColor,
                    number: deaths,
                    title: "Deaths",
                  ),
                  Counter(
                    color: kRecovercolor,
                    number: recovered,
                    title: "Recovered",
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
