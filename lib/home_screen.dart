import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = [
    const Color(0xFF212EF3),
    const Color(0xFF00A801),
    const Color(0xFFF32126),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              FutureBuilder(
                  future: statesServices.fetchworldstatesrecord(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total': double.parse(
                                  snapshot.data!.cases!.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered!.toString()),
                              'Deaths': double.parse(
                                  snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius: MediaQuery.of(context).size.width / 3,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Card(
                            child: Column(
                              children: [
                                Reuseable(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                Reuseable(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                Reuseable(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                Reuseable(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                                Reuseable(
                                    title: 'Active Cases',
                                    value: snapshot.data!.active.toString()),
                                Reuseable(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                Reuseable(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF00A801),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Text('Track Countries',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15))),
                            ),
                          )
                        ],
                      );
                    }
                    ;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Reuseable extends StatelessWidget {
  String title, value;
  Reuseable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          )
        ],
      ),
    );
  }
}
