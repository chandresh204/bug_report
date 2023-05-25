import 'package:flutter/material.dart';

class ImprovementForm extends StatefulWidget {
  bool gotoEditMode;
  ImprovementForm({Key? key, required this.gotoEditMode}) : super(key: key);

  @override
  State<ImprovementForm> createState() => _ImprovementFormState();
}

class _ImprovementFormState extends State<ImprovementForm> {

  String impact = 'Low';
  bool inEditMode = false;
  double improvementStatus = 0.0;

  @override
  Widget build(BuildContext context) {
    return _improvementEditUI();
  }

  Widget _improvementEditUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Improvement'),
      ),
      body: ListView(
        padding:
            EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100),
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Impact: ',
                style: TextStyle(fontSize: 22),
              )),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Impact of Improvement on project',
                                style: TextStyle(fontSize: 22),
                              ),
                              Container(
                                height: 20,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(onPressed: () {
                                    impact = 'Low';
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                      child: Text('Low')),
                                  Container(width: 10,),
                                  ElevatedButton(onPressed: () {
                                    impact = 'Medium';
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                      child: Text('Medium')),
                                  Container(width: 10,),
                                  ElevatedButton(onPressed: () {
                                    impact = 'High';
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                    child: Text('High'),
                                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red)),),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Text('impact'),
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          Container(
            height: 20,
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Improvement Steps',
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            height: 20,
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Possibilities of Errors',
              border: OutlineInputBorder(),
            ),
          ),
          Container(height: 20,),
          Row(
            children: [
              Text('Compeleted : ${improvementStatus.toInt()}%', style: TextStyle(fontSize: 22), )
            ],
          ),
          Slider(
            max: 100.0,
              value: improvementStatus,
              onChanged: (value) {
                print('new value :$value');
                improvementStatus = value;
                setState(() {});
              }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {

      }, child: Icon(Icons.check),),
    );
  }
}
