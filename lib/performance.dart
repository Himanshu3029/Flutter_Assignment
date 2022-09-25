// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;

class Performance extends StatefulWidget {
  const Performance({Key? key}) : super(key: key);

  @override
  State<Performance> createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  var url =
      "https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en";

  var data;
  var percent;
  List percentprogress = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await http.get(Uri.parse(url));
    data = jsonDecode(res.body);
    for (var i = 0; i < data.length; i++) {
      double pc = data[i]['ChangePercent'];
      percent = pc.toStringAsFixed(2);
      data[i]['ChangePercent'] = percent;

      pc = pc / 400;
      if (pc < 0) {
        pc = (-1 * pc);
      }
      percent = pc.toStringAsFixed(3);
      percentprogress.add(double.parse(percent));

      // print(percentprogress[i]);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: (loading)
            ? const CircularProgressIndicator()
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Performance",
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 74, 129),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return (double.parse(data[index]['ChangePercent']) > 0)
                            ? ListTile(
                                leading: Text(data[index]['Label']),
                                title: LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  lineHeight: 20,
                                  percent: percentprogress[index],
                                  linearStrokeCap:
                                      // ignore: deprecated_member_use
                                      LinearStrokeCap.roundAll,
                                  backgroundColor: Colors.grey.shade400,
                                  progressColor: Colors.green.shade900,
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(data[index]['ChangePercent'],
                                          style: TextStyle(
                                              color: Colors.green.shade900)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ]))
                            : ListTile(
                                leading: Text(data[index]['Label']),
                                title: LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  lineHeight: 20,
                                  percent: percentprogress[index],
                                  // ignore: deprecated_member_use
                                  linearStrokeCap:
                                      // ignore: deprecated_member_use
                                      LinearStrokeCap.roundAll,
                                  backgroundColor: Colors.grey.shade400,
                                  progressColor: Colors.red.shade900,
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data[index]['ChangePercent'],
                                        style: TextStyle(
                                            color: Colors.red.shade900),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ]));
                      },
                      itemCount: data.length,
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "View More",
                            style: TextStyle(color: Colors.amber.shade600),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ]));
  }
}
