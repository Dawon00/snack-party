import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:snackparty/model/party.dart';

class AddPartyScreen extends StatefulWidget {
  const AddPartyScreen({Key? key}) : super(key: key);

  @override
  State<AddPartyScreen> createState() => _AddPartyScreenState();
}

class _AddPartyScreenState extends State<AddPartyScreen> {
  final controllerPartyTitle = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerTime = TextEditingController();
  final controllerPlace = TextEditingController();
  final controllerInfo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference party = FirebaseFirestore.instance.collection('party');
    return Scaffold(
      appBar: AppBar(
        title: Text('파티 생성'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '파티명',
                        hintText: '파티명을 입력하세요',
                      ),
                      controller: controllerPartyTitle,
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: FormBuilderDateTimePicker(
                      controller: controllerDate,
                      name: '날짜',
                      inputType: InputType.date,
                      decoration: const InputDecoration(labelText: '날짜'),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: FormBuilderDateTimePicker(
                      controller: controllerTime,
                      name: '시간',
                      inputType: InputType.time,
                      decoration: const InputDecoration(labelText: '시간'),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: TextFormField(
                      controller: controllerPlace,
                      decoration: InputDecoration(
                        labelText: '장소',
                        hintText: '장소를 입력하세요',
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: TextFormField(
                      controller: controllerInfo,
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      //expands: true,
                      decoration: InputDecoration(
                        labelText: '추가 설명',
                        hintText: '추가설명을 입력하세요',
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text('생성하기'),
                        onPressed: () {
                          final party = Party(
                            partytitle: controllerPartyTitle.text,
                            place: controllerPlace.text,
                            info: controllerInfo.text,
                            id: UniqueKey().toString(),
                            author: FirebaseAuth.instance.currentUser!.uid,
                            partymember: [],
                          );
                          createParty(party);
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  //Dialog Main Title
                                  title: Column(
                                    children: <Widget>[
                                      new Text("파티 생성"),
                                    ],
                                  ),
                                  //
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "완료되었습니다.",
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("확인"),
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
      ),
    );
  }
}

Future createParty(Party party) async {
  final docParty = FirebaseFirestore.instance.collection('party').doc();
  final json = party.toJson();
  await docParty.set(json);
}
