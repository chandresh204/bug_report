import 'package:flutter/material.dart';
import 'improvement_form.dart';
import 'bug_form.dart';

class ProjectDashboard extends StatefulWidget {
  const ProjectDashboard({Key? key}) : super(key: key);

  @override
  State<ProjectDashboard> createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard>
  with SingleTickerProviderStateMixin {

  final tabs = const <Tab>[
    Tab(text: 'Bugs', icon: Icon(Icons.bug_report_outlined),),
    Tab(text: 'Improvement', icon: Icon(Icons.arrow_circle_up_sharp),),
  ];

  @override
  Widget build(BuildContext context) {
    return

      DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text('My Project Name'), bottom: TabBar(tabs: tabs,)),
            body: _tabBarView(),
          );
        },
        ),
    );
  }

  Widget _tabBarView() {
    return TabBarView(children: tabs.map((e) {
      if (e.text == 'Bugs') {
        return BugsListWidget();
      }
      return ImprovemetListWidget();
    }).toList());
  }
}

class BugsListWidget extends StatefulWidget {
  const BugsListWidget({Key? key}) : super(key: key);

  @override
  State<BugsListWidget> createState() => _BugsListWidgetState();
}

class _BugsListWidgetState extends State<BugsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BugForm(goToEdit: true,);
          }));
        },
        child: Icon(Icons.add),),
    );
  }
}

class ImprovemetListWidget extends StatefulWidget {
  const ImprovemetListWidget({Key? key}) : super(key: key);

  @override
  State<ImprovemetListWidget> createState() => _ImprovemetListWidgetState();
}

class _ImprovemetListWidgetState extends State<ImprovemetListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text('Improvements will be here'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImprovementForm(gotoEditMode: true)));
        },
        child: Icon(Icons.add),
      ),
    );;
  }
}


