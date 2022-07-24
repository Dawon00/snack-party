import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snackparty/model/party.dart';
import 'package:snackparty/screen/home_screen.dart';
import 'package:snackparty/widget/bar_button.dart';

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
        title: const Text('파티 생성'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: '파티명',
                      hintText: '파티명을 입력하세요',
                    ),
                    controller: controllerPartyTitle,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: controllerPlace,
                    decoration: const InputDecoration(
                      labelText: '장소',
                      hintText: '장소를 입력하세요',
                    ),
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
                  child: TextFormField(
                    controller: controllerInfo,
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    //expands: true,
                    decoration: const InputDecoration(
                      labelText: '추가 설명',
                      hintText: '추가설명을 입력하세요',
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: BarButton(
                      child: const Text('생성하기'),
                      onPressed: () {
                        final docParty = firestore.collection('party').doc();

                        final partytitle = controllerPartyTitle.text;
                        final datetime = dateTime;
                        final place = controllerPlace.text;
                        final info = controllerInfo.text;
                        id:
                        docParty.id;
                        final author = FirebaseAuth.instance.currentUser!.uid;
                        final partymember = [];

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
