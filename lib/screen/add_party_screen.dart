import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snackparty/model/party.dart';
import 'package:snackparty/screen/home_screen.dart';
import 'package:snackparty/widget/bar_button.dart';
import 'package:snackparty/widget/input_field.dart';

class AddPartyScreen extends StatefulWidget {
  const AddPartyScreen({Key? key}) : super(key: key);

  @override
  State<AddPartyScreen> createState() => _AddPartyScreenState();
}

class _AddPartyScreenState extends State<AddPartyScreen> {
  final controllerPartyTitle = TextEditingController();
  final controllerPlace = TextEditingController();
  final controllerInfo = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  bool showDateTime = false;

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  // select date time picker
  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);

    if (!mounted) return;
    final time = await _selectTime(context);

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference party = FirebaseFirestore.instance.collection('party');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          '파티 만들기',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20)),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: InputField(
                    minLines: 1,
                    maxLines: 1,
                    hintText: '파티명',
                    textEditingController: controllerPartyTitle,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: InputField(
                    minLines: 1,
                    maxLines: 1,
                    hintText: '장소',
                    textEditingController: controllerPlace,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDateTime(context);
                      showDateTime = true;
                    },
                    child: showDateTime
                        ? Text(
                            DateFormat('yyyy-MM-dd hh:mm a').format(dateTime),
                          )
                        : const Text('약속일자 선택하기'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: InputField(
                    maxLines: 10,

                    textEditingController: controllerInfo,
                    minLines: 6,
                    textInputType: TextInputType.multiline,
                    //expands: true,
                    hintText: '추가설명',
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: BarButton(
                      child: const Text('완료',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        final docParty = firestore.collection('party').doc();

                        final partytitle = controllerPartyTitle.text;
                        final datetime = dateTime;
                        final place = controllerPlace.text;
                        final info = controllerInfo.text;
                        //id: docParty.id;
                        final author = FirebaseAuth.instance.currentUser!.uid;
                        final partymember = [author];

                        createParty(
                            partytitle: partytitle,
                            datetime: datetime,
                            place: place,
                            info: info,
                            author: author,
                            partymember: partymember);
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //Dialog Main Title
                                title: Column(
                                  children: const <Widget>[
                                    Text("파티 생성"),
                                  ],
                                ),
                                //
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[
                                    Text(
                                      "완료되었습니다.",
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text("확인"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

Future createParty({
  required String partytitle,
  required DateTime datetime,
  required String place,
  required String info,
  required String author,
  required List partymember,
}) async {
  final docParty = FirebaseFirestore.instance.collection('party').doc();
  final json = {
    'id': docParty.id,
    'partytitle': partytitle,
    'datetime': datetime,
    'place': place,
    'info': info,
    'author': author,
    'partymember': partymember,
  };
  await docParty.set(json);
}
