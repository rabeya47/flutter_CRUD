import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hw/helper/http_helper.dart';
import 'package:hw/view/model/massage_model.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);


  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final _formKey = GlobalKey<FormState>();
  final _http = HttpHelper();

  final _subject = TextEditingController();
  final _content = TextEditingController();

  // TextEditingController subjectController = TextEditingController();
  // TextEditingController contentController = TextEditingController();



  save() async{
    String sub = _subject.value.toString() ?? '';
    String cont = _content.value.toString() ?? '';
    var model = MessageModel(subject: sub, content: cont);
    String _body = model.toJson();

    try{
      final response = await _http.postData('http://localhost:8081/save', _body);

    }catch(e){
       log(e.toString());
       Fluttertoast.showToast(
           msg: "$e",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sand Box'),),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _subject,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "subject",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _content,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Content",
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Send'),
                  onPressed: () {
                    this.save();
                    print(_subject.text);
                    print(_content.text);
                  },
                )
            ),
          ],
        ),

      )
    );
  }
}
