import 'package:flutter/material.dart';
import 'package:startup_fintech_pt_bkn/data/database_helper.dart';
import 'package:startup_fintech_pt_bkn/screens/pemasukan_screen.dart';
import 'package:startup_fintech_pt_bkn/screens/pengeluaran_screen.dart';
import 'package:startup_fintech_pt_bkn/screens/cashFlow_screen.dart';
import 'package:startup_fintech_pt_bkn/screens/setting_screen.dart';

class HomePage extends StatefulWidget {
  final int id_user;
  const HomePage({Key? key, required this.id_user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<int> income;
  late Future<int> outcome;
  late Future<String> name;

  @override
  void initState() {
    super.initState();
    income = DatabaseHelper().totalIncome(id_user: widget.id_user);
    outcome = DatabaseHelper().totalOutcome(id_user: widget.id_user);
  }

  @override
  Widget build(BuildContext context) {
    extendBody:
    true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            const Text(
              "Rangkuman Bulan Ini",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<int>(
              future: income,
              builder: (context, incomeSnapshot) {
                if (incomeSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (incomeSnapshot.hasError) {
                  return Text("Error: ${incomeSnapshot.error}");
                } else {
                  return FutureBuilder<int>(
                    future: outcome,
                    builder: (context, outcomeSnapshot) {
                      if (outcomeSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (outcomeSnapshot.hasError) {
                        return Text("Error: ${outcomeSnapshot.error}");
                      } else {
                        return Column(
                          children: [
                            Text(
                              "Pengeluaran: Rp. ${outcomeSnapshot.data}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              "Pemasukan: Rp. ${incomeSnapshot.data}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                }
              },
            ),
            Image.asset(
              'lib/images/line_chart.png',
              height: 300.0,
              width: 300.0,
            ),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: <Widget>[
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PemasukanPage(
                            id_user: widget.id_user,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('lib/images/income.png',
                            height: 70, width: 70),
                        SizedBox(height: 10),
                        Text(
                          'Pemasukan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PengeluaranPage(
                          id_user: widget.id_user,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/outcome.png',
                          height: 70, width: 70),
                      SizedBox(height: 10),
                      Text(
                        'Pengeluaran',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CashFlowPage(
                          id_user: widget.id_user,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/cash-flow.png',
                          height: 70, width: 70),
                      SizedBox(height: 10),
                      Text(
                        'Detail Cash Flow',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingPage(
                          id_user: widget.id_user,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/setting.png',
                          height: 70, width: 70),
                      SizedBox(height: 10),
                      Text(
                        'Pengaturan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
