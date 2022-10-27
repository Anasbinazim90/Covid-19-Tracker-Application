import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countrieslistApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading... Please wait');
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];

                          if (searchcontroller.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  totalCases: snapshot
                                                      .data![index]['cases'],
                                                  totalRecovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  totalDeaths: snapshot
                                                      .data![index]['deaths'],
                                                  criticalCases: snapshot
                                                      .data![index]['critical'],
                                                  activeCases: snapshot
                                                      .data![index]['active'],
                                                  todayCases:
                                                      snapshot.data![index]
                                                          ['todayCases'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                )));
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  ),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  totalCases: snapshot
                                                      .data![index]['cases'],
                                                  totalRecovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  totalDeaths: snapshot
                                                      .data![index]['deaths'],
                                                  criticalCases: snapshot
                                                      .data![index]['critical'],
                                                  activeCases: snapshot
                                                      .data![index]['active'],
                                                  todayCases:
                                                      snapshot.data![index]
                                                          ['todayCases'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                )));
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                  ;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
