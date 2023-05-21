import 'package:flutter/material.dart';
import 'package:hpb/models/covid_data_model.dart';
import 'package:hpb/models/pcr_model.dart';
import 'package:hpb/services/api_service.dart';

import '../components/custom_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
        future: service.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CovidDataModel data = snapshot.data!;
            List<PcrData> pcrDataList = data.pcrData!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu),
                      Text(
                        "Covid 19",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      Icon(Icons.add_location)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        size: size,
                        title: 'Total Deaths',
                        color: Colors.red,
                        value: data.totalDeaths!,
                      ),
                      CustomContainer(
                        size: size,
                        title: 'Total Recovered',
                        color: Colors.green,
                        value: data.totalRecovered!,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        size: size,
                        title: 'Active Cases',
                        color: Colors.blue,
                        value: data.activeCases!,
                      ),
                      CustomContainer(
                        size: size,
                        title: 'Total Cases',
                        color: Colors.amber.shade800,
                        value: data.totalCases!,
                      ),
                    ],
                  ),
                  const Text(
                    "Daily Pcr Test",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pcrDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pcrDataList[index].date.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              pcrDataList[index].count.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
