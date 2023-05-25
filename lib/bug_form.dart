import 'package:flutter/material.dart';

class BugForm extends StatefulWidget {
  bool goToEdit;
  BugForm({Key? key, required this.goToEdit}) : super(key: key);
  static List<String>  affectedDevices = [];

  @override
  State<BugForm> createState() => _BugFormState();
}

class _BugFormState extends State<BugForm> {

  String impact = 'Low';
  bool inEditMode = false;

  @override
  void initState() {
    inEditMode = widget.goToEdit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getBugView();
  }

  Widget _getBugView() {
    if (inEditMode) {
      return _bugEditUI();
    }
    return _bugViewUI();
  }

  Widget _bugViewUI() {
    return Scaffold(
      appBar: AppBar(title: Text('Bug'),),
      body: ListView(
        padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: 100),
        children : [
          Text('Bug Name', style: TextStyle(fontSize: 22),),
          Text('Bug Description', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),),
          Container(height: 20,),
          Text('Impact on Functionality : High', style: TextStyle(fontSize: 18),),
          Container(height: 20,),
          Text('Steps to reproduce', style: TextStyle(fontSize: 18),),
          Container(height: 20,),
          Text('Error Logs: ',  style: TextStyle(fontSize: 18),),
          Container(height: 20,),
          Text('Observed on Devices: ', style: TextStyle(fontSize: 18), ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            inEditMode = true;
          });
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget _bugEditUI() {
    return Scaffold(
      appBar: AppBar(title: Text('Bug'),),
      body: ListView(
        padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100),
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          Container(height: 20,),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          Container(height: 20,),
          Row(
            children: [
              Expanded(child: Text('Impact: ', style: TextStyle(fontSize: 22),)),
              ElevatedButton(onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Impact of this Bug on Project', style: TextStyle(fontSize: 22),),
                        Container(height: 20,),
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
              }, child: Text(impact),),
            ],
          ),
          Container(height: 20,),
          Row(
            children: [
              Expanded(child: Text('Observed Devices', style: TextStyle(fontSize: 22),)),
              Text(BugForm.affectedDevices.length.toString()),
              Container(width: 9,),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DeviceListPage()));
              }, child: Text('List')),
            ],
          ),
          Container(height: 20,),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Steps to reproduce',
              border: OutlineInputBorder(),
            ),
          ),
          Container(height: 20,),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Error Logs',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({Key? key}) : super(key: key);

  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Affected devices')),
      body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children : [
            ListView.builder(
                padding: EdgeInsets.only(bottom: 100, right: 10, left: 10),
                itemCount: BugForm.affectedDevices.length,
                itemBuilder: (context, i) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 8,),
                      Text(BugForm.affectedDevices[i], style: TextStyle(fontSize: 22),),
                      Divider(color: Colors.blue, thickness: 2,)
                    ],
                  );
                }),
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Enter Device Details', style: TextStyle(fontSize: 22),),
                        TextField(
                          controller: _controller1,
                          decoration: InputDecoration(
                            labelText: 'Device Name',
                            hintText: 'e.g. Lenovo xx',
                          ),
                        ),
                        TextField(
                          controller: _controller2,
                          decoration: InputDecoration(
                            labelText: 'Operating System',
                            hintText: 'e.g. Android 11',
                          ),
                        ),
                        Container(height: 20,),
                        ElevatedButton(onPressed: () {
                          if (_controller1.text.isEmpty || _controller2.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('All values required'))
                            );
                            return;
                          }
                          BugForm.affectedDevices.add(_controller1.text + ':' + _controller2.text);
                          Navigator.pop(context);
                          setState(() { });
                        },
                            child: Text('Save'))
                      ],
                    ),
                  ),
                );
              });
            },
                child: Text('Add Device'))
          ]
      ),
    );
  }
}

