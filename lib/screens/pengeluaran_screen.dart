import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startup_fintech_pt_bkn/data/database_helper.dart';
import 'package:startup_fintech_pt_bkn/screens/cashFlow_screen.dart';
import 'package:intl/intl.dart';

class PengeluaranPage extends StatefulWidget {
  final int id_user;
  const PengeluaranPage({Key? key, required this.id_user}) : super(key: key);

  @override
  _PengeluaranPageState createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                'Tambah Pengeluaran',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dateController,
              onChanged: (value) => setState(() => null),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tanggal',
                suffixIcon: IconButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(
                        () {
                          dateController.text =
                              formattedDate; //set output date to TextField value.
                        },
                      );
                    } else {
                      print("Date is not selected");
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ),
            ),
            TextFormField(
              controller: nominalController,
              onChanged: (value) => setState(() => null),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                prefixText: 'Rp ',
                labelText: 'Nominal',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              onChanged: (value) => setState(() => null),
              decoration: InputDecoration(
                labelText: 'Keterangan',
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      dateController.clear(),
                      nominalController.clear(),
                      descriptionController.clear(),
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                    ),
                    child: Text('Reset'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (dateController.text.isEmpty ||
                          nominalController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Data tidak boleh kosong.'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        DatabaseHelper().addOutcome(
                            widget.id_user,
                            dateController.text,
                            int.parse(nominalController.text),
                            descriptionController.text,
                            context);
                      }
                    },
                    child: Text('Simpan'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text('Kembali'),
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
