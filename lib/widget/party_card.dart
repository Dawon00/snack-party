import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snackparty/model/party.dart';

class PartyCard extends StatelessWidget {
  final Party party;
  const PartyCard({Key? key, required this.party}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(party.partytitle),
        subtitle: Text(
            "${DateFormat('yyyy-MM-dd hh:mm a').format(party.datetime)} / ${party.place}"),
      ),
    );
  }
}
