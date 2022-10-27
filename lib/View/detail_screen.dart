import 'package:covid_tracker/home_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalRecovered,
      totalDeaths,
      criticalCases,
      activeCases,
      todayCases,
      todayRecovered;

  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.todayRecovered,
    required this.totalDeaths,
    required this.criticalCases,
    required this.activeCases,
    required this.todayCases,
    required this.totalRecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Card(
                    child: Column(
                      children: [
                        Reuseable(
                            title: 'Total',
                            value: widget.totalCases.toString()),
                        Reuseable(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        Reuseable(
                            title: 'Deaths',
                            value: widget.totalDeaths.toString()),
                        Reuseable(
                            title: 'Critical',
                            value: widget.criticalCases.toString()),
                        Reuseable(
                            title: 'Active Cases',
                            value: widget.activeCases.toString()),
                        Reuseable(
                            title: 'Today Cases',
                            value: widget.todayCases.toString()),
                        Reuseable(
                            title: 'Today Recovered',
                            value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ));
  }
}
