import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_txt/open_txt.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent),
      home: const CKHomePage(),
    );
  }
}

class CKHomePage extends StatefulWidget {
  const CKHomePage({Key? key}) : super(key: key);

  @override
  State<CKHomePage> createState() => _CKHomePageState();
}

class _CKHomePageState extends State<CKHomePage> {
  late String _filePath;

  var _result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _result = FilePicker.platform.pickFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Txt文本打开"),
      ),
      body: FutureBuilder(
        future: _result,
        builder: (ctx, AsyncSnapshot<FilePickerResult?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          _filePath = snapshot.data!.files.first.path!;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _filePath,
                  style: const TextStyle(fontSize: 20),
                ),
                RaisedButton(
                  child: const Text("打开文件"),
                  onPressed: () {
                    OpenTxt.sendDataToNative(_filePath);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
