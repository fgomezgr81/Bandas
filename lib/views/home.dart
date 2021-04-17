import 'dart:io';

import 'package:bandas/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: '5'),
    Band(id: '2', name: 'Angeles azules', votes: '10'),
    Band(id: '3', name: 'Heroes del sinlencio', votes: '6'),
    Band(id: '4', name: 'BTS', votes: '8')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Bands name',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => bandsTitle(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget bandsTitle(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //llamar el borrao del server
      },
      background: Container(
        padding: EdgeInsets.only(left: 15.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Eliminar',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            band.name.substring(0, 2),
          ),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  addNewBand() {
    final textcontroller = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nueva banda'),
            content: TextField(
              controller: textcontroller,
            ),
            actions: [
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                child: Text('Agregar'),
                onPressed: () => addBandToList(textcontroller.text),
              ),
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('Nueva banda'),
          content: CupertinoTextField(
            controller: textcontroller,
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Agregar'),
              isDefaultAction: true,
              onPressed: () => addBandToList(
                textcontroller.text,
              ),
            ),
            CupertinoDialogAction(
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //se agrega
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: '3'));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
