import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class StorageWriteUtility {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference _reference, _catReference;
  String title, category;

  StorageWriteUtility(this.title, this.category) {
    this.title += '.txt';
    this.category = '/' + this.category + '/';
    this._catReference = storage.ref('all' + this.category + this.title);
    this._reference = storage.ref(ob.email + this.category + this.title);
  }

  void writeString(String data) async {
    await _reference.putString(data);
    await _catReference.putString(data);
  }
}

class CreatePage2 extends StatelessWidget {
  CreatePage2(this.title, this.category);
  final String title, category;
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          child: Column(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  maxLines: 20,
                  autocorrect: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Your content here',
                    border: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onFieldSubmitted: (content) {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                    var util = StorageWriteUtility(this.title, this.category);
                    util.writeString(_controller.text);
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                  var util = StorageWriteUtility(this.title, this.category);
                  util.writeString(_controller.text);
                },
                child: Text(
                  'Publish',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}