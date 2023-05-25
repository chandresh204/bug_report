import 'package:bug_report/constants.dart';
import 'package:flutter/material.dart';

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({Key? key}) : super(key: key);

  @override
  State<NewProjectScreen> createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {

  final List<String> _memberList = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Project')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _mainBody(),
      ),
    );
  }

  Widget _mainBody() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),
              ),
            ),
            Container(height: 20,),
            const Text('---Members---', style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),),
            //   _membersUI(),
            SizedBox(
              height: _memberList.length * 17,
              child: ListView.builder(
                  itemCount: _memberList.length,
                  itemBuilder: (context, i) {
                    return Text(_memberList[i]);
                  }),
            ),
            Container(height: 20,),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: _memberController,
                    decoration: const InputDecoration(
                        labelText: 'Member Contact Number',
                        hintText: 'e.g. +91888888888',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(16.0),
                    child: ElevatedButton(onPressed: () {
                      if (_memberController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please provide member number')),
                        );
                        return;
                      }
                      _addProjectMember(_memberController.text);
                      _memberController.text = '';
                    },
                        child: const Text('Add Member')))
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
        ElevatedButton(
            onPressed: () {
              if(_nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please provide project Name')),
                );
                return;
              }
              _createNewProject();
            },
            child: const Text('Create Project')),
      ],
    );
  }

  _addProjectMember(String contact) {
    _memberList.add(contact);
    setState(() {});
  }

  _createNewProject() {
    //TODO('create new project on firebase')
    showModalBottomSheet(context: context, builder: (context) {
      final projectName = _nameController.text;
      Constants.dbRef.child(projectName).child(Constants.members).set(_memberList)
          .whenComplete(() {
        Navigator.pop(context);
        Navigator.pop(context);
      });
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Container(height: 20),
            const Text('Creating Project', style: TextStyle(fontSize: 22))
          ],
        ),
      );
    });
  }
}
