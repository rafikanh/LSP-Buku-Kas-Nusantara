import 'package:flutter/material.dart';
import 'package:startup_fintech_pt_bkn/data/database_helper.dart';
import 'package:startup_fintech_pt_bkn/models/cashFlow_model.dart';

class CashFlowPage extends StatefulWidget {
  final int id_user;
  const CashFlowPage({Key? key, required this.id_user}) : super(key: key);

  @override
  _CashFlowPageState createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'Detail Cash Flow',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<CashFlow>>(
              future: DatabaseHelper().all(widget.id_user),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.length == 0) {
                    return Center(
                      child: Text('Data Tidak Ditemukan'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        // Menampilkan data dari snapshot ke dalam UI
                        return cardCashFlow(
                          snapshot.data?[index].type == "income"
                              ? Icons.arrow_back
                              : Icons.arrow_forward,
                          snapshot.data?[index].type == "income"
                              ? Colors.green.shade400
                              : Colors.red.shade400,
                          snapshot.data?[index].type == "income" ? "+" : "-",
                          snapshot.data![index].total.toString(),
                          snapshot.data![index].description.toString(),
                          snapshot.data![index].date.toString(),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali')),
        ),
      ),
    );
  }

  Card cardCashFlow(IconData icon, Color color, String sign, String nominal,
      String description, String date) {
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("[ " + sign + " ] Rp. " + nominal,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Container(
                    width: 200,
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Icon(icon, color: color),
            ]),
      ),
    );
  }
}
