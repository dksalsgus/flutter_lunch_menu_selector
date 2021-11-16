import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanchMenu extends StatefulWidget {
  @override
  State<LanchMenu> createState() => _LanchMenuState();
}

class _LanchMenuState extends State<LanchMenu> {
  final List<String> _menuList = [];
  final _addMenuController = TextEditingController();

  @override
  void dispose() {
    _addMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '점심 메뉴 생성기',
          style: TextStyle(color: Colors.amber),
        ),
        actions: [
          IconButton(
              onPressed: () => _getBottomSheet(),
              icon: Icon(Icons.add_outlined))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: Text(_menuList.toString()),
      ),
    );
  }

  void _getBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return _buildBottomSheet(context);
        });
  }

  void _addMenu(String menu) {
    if (menu.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Column(
                children: [Text('음식점을 입력해주세요')],
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('확인'))
              ],
            );
          });
      return;
    }
    setState(() {
      _menuList.add(menu);
      print(menu);
    });
    print(_menuList.toString());
    _addMenuController.clear();
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              child: Text(
                '음식점 추가',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              margin: EdgeInsets.all(10),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _addMenuController,
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () => _addMenu(_addMenuController.text),
                    child: Text('추가하기')))
          ],
        ),
      ),
    );
  }
}
