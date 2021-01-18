import 'package:flutter/material.dart';
import 'createPage2.dart';

class CreatePage1 extends StatelessWidget {
  final _controller = TextEditingController();
  final _categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  var category = 'Misc';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                controller: _categoryController,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: 'Category',
                  hintText: 'Science',
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onSubmitted: (val) {
                  category = val;
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                controller: _controller,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'My awesome experience',
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onSubmitted: (content) {
                  if (_categoryController.text != '') {
                    category = _categoryController.text;
                  }
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage2(_controller.text, category)));
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            FlatButton(
              onPressed: () {
                if (_categoryController.text != '') {
                  category = _categoryController.text;
                }
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage2(_controller.text, category)));
              },
              color: Colors.lightBlue,
              child: Text(
                'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
