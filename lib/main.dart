import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2021奥运会奖牌榜',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: '2021奥运会奖牌榜'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> scoreList = [
    {
      'flag': 'america.jpeg',
      'country': "美国",
      'gold_medal': 39,
      'silver_medal': 41,
      'bronze_medal': 33,
      'total': 113,
    },
    {
      'flag': 'china.jpeg',
      'country': "中国",
      'gold_medal': 38,
      'silver_medal': 32,
      'bronze_medal': 18,
      'total': 88,
    },
    {
      'flag': 'japan.jpeg',
      'country': "日本",
      'gold_medal': 27,
      'silver_medal': 14,
      'bronze_medal': 17,
      'total': 58,
    },
    {
      'flag': 'korean.jpeg',
      'country': "韩国",
      'gold_medal': 17,
      'silver_medal': 12,
      'bronze_medal': 13,
      'total': 42,
    }
  ];

  Map currSortOrder = {
    'gold_medal': 'ASC',
    'silver_medal': 'ASC',
    'bronze_medal': 'ASC',
    'total': 'ASC',
  };

  String currKey = 'gold_medal';

  List<Map> _getSortedList(String sortKey) {
    if (currSortOrder[sortKey] == "ASC") {
      currSortOrder[sortKey] = "DESC";
      scoreList.sort((a, b) => doCompare(b, a, sortKey));
    } else {
      currSortOrder[sortKey] = "ASC";
      scoreList.sort((a, b) => doCompare(a, b, sortKey));
    }
    return scoreList;
  }

  int doCompare(Map a, Map b, String sortKey) {
    int ret = 0;
    List keys = ["gold_medal", "silver_medal", "bronze_medal", "total"];
    int count = 0;
    int index = keys.indexOf(sortKey);
    while (ret == 0 && count < keys.length) {
      String key = keys[index % keys.length];
      ret = a[key].compareTo(b[key]);
      index++;
      count++;
    }
    return ret;
  }

  Column _createListView(String sortKey) {
    scoreList = _getSortedList(sortKey);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 11,
              child: Container(
                child: GestureDetector(
                  child: Text(
                    "排名",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                child: GestureDetector(
                  child: Text(
                    "国家",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: Container(
                child: GestureDetector(
                  child: Text(
                    "金",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  onTap: () => {_sortListView('gold_medal')},
                  behavior: HitTestBehavior.opaque,
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: Container(
                child: GestureDetector(
                  child: Text(
                    "银",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  onTap: () => {_sortListView('silver_medal')},
                  behavior: HitTestBehavior.opaque,
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: Container(
                child: GestureDetector(
                  child: Text(
                    "铜",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  onTap: () => {_sortListView('bronze_medal')},
                  behavior: HitTestBehavior.opaque,
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: Container(
                child: GestureDetector(
                  child: Text(
                    "总数",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  onTap: () => {_sortListView('total')},
                  behavior: HitTestBehavior.opaque,
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.blue,
        ),
        Expanded(
          child: Container(
            child: ListView.separated(
              itemCount: scoreList.length,
              itemBuilder: (BuildContext context, int index) {
                // return ListTile(title: Text("$index"));
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 10,
                      child: Text((index + 1).toString(),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                        flex: 20,
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(
                                'image/' + scoreList[index]['flag'],
                                width: 20,
                                height: 20,
                              ),
                              Text('  '),
                              Text(scoreList[index]['country']),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 10,
                      child: Text(scoreList[index]['gold_medal'].toString(),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 10,
                      child: Text(scoreList[index]['silver_medal'].toString(),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 10,
                      child: Text(scoreList[index]['bronze_medal'].toString(),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 10,
                      child: Text(scoreList[index]['total'].toString(),
                          textAlign: TextAlign.center),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.blue,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _sortListView(String? key) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (key != null) {
        currKey = key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _createListView(currKey),
    );
  }
}