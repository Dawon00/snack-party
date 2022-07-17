import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddPartyScreen extends StatefulWidget {
  const AddPartyScreen({Key? key}) : super(key: key);

  @override
  State<AddPartyScreen> createState() => _AddPartyScreenState();
}

class _AddPartyScreenState extends State<AddPartyScreen> {
  @override
  Widget build(BuildContext context) {
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
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: FormBuilderDateTimePicker(
                      name: '날짜',
                      inputType: InputType.date,
                      decoration: const InputDecoration(labelText: '날짜'),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: FormBuilderDateTimePicker(
                      name: '시간',
                      inputType: InputType.time,
                      decoration: const InputDecoration(labelText: '시간'),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '장소',
                        hintText: '장소를 입력하세요',
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: TextFormField(
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
                    child:
                        ElevatedButton(child: Text('생성하기'), onPressed: () {}),
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
