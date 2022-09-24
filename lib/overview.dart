// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  var url =
      'https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en';

  var data;
  var sector, Yield, PE, industry, EV, MCAP, PEGRatio, BookNavPerShare;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    try {
      var res = await http.get(Uri.parse(url));
      data = jsonDecode(res.body);
      // print(data);

      sector = data['Sector'];

      industry = data['Industry'];
      EV = data['EV'];

      double Mcap = data['MCAP'] / 10000000;
      MCAP = Mcap.toStringAsFixed(2);

      Mcap = data['PEGRatio'];
      PEGRatio = Mcap.toStringAsFixed(2);

      Mcap = data['TTMPE'];
      PE = Mcap.toStringAsFixed(2);

      Mcap = data["Yield"];
      Yield = Mcap.toStringAsFixed(2);

      Mcap = data["BookNavPerShare"];
      BookNavPerShare = Mcap.toStringAsFixed(2);

      setState(() {});
    } catch (e) {
      ErrorHint("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: (data == null)
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      "Overview",
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
                  ListTile(
                      leading: const Text(
                        'Sector',
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(
                          Icons.account_balance_outlined,
                          color: Color.fromARGB(255, 212, 142, 51),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(sector),
                        const SizedBox(
                          width: 10,
                        ),
                      ])),
                  ListTile(
                      leading: const Text(
                        "Industry",
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(
                          Icons.account_balance,
                          color: Color.fromARGB(255, 212, 142, 51),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(industry),
                        const SizedBox(
                          width: 10,
                        ),
                      ])),
                  ListTile(
                    leading: const Text(
                      "Market Cap.",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${MCAP}cr"),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Text(
                      "Enterprise Value (EV)",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (EV == null)
                            ? const Text('-')
                            : const CircularProgressIndicator(),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Text(
                      "Book Value / Share",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(BookNavPerShare),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Text(
                      "Price-Earning Ratio(PE)",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(PE),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Text(
                      "PEG Ratio",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ignore: prefer_const_constructors
                        Text(PEGRatio),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Text(
                      "Dividend Yield",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(Yield),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
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
      ),
    );
  }
}
