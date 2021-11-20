import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LunchMenu extends StatefulWidget {
  @override
  State<LunchMenu> createState() => _LunchMenuState();
}

class _LunchMenuState extends State<LunchMenu> {
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
        title: const Text(
          '점심 메뉴 생성기',
          style: TextStyle(color: Colors.amber),
        ),
        actions: [
          IconButton(
              onPressed: () => _getBottomSheet(),
              icon: const Icon(Icons.add_outlined))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: _getBody(),
      ),
    );
  }

  void _selectButtonEvent() {
    if (_menuList.length >= 3) {
      _getRandomMenu();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text('메뉴를 3개 이상 추가해주세요'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('OK'))
              ],
            );
          });
    }
  }

  void _getRandomMenu() {
    print('random');
    Random _random = new Random();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text('오늘의 메뉴는?'),
            content: Text(_menuList[_random.nextInt(_menuList.length)]),
          );
        });
  }

  Widget _getBody() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
          ),
          const Text(
            '점심 메뉴 리스트',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 100,
          ),
          Text(
            _menuList.toString(),
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(
            width: double.infinity,
            height: 100,
          ),
          ElevatedButton(
              onPressed: () => _selectButtonEvent(), child: Text('랜덤 뽑기')),
          ElevatedButton(onPressed: () => _resetButton(), child: Text('Reset'))
        ],
      ),
    );
  }

  void _resetButton() {
    setState(() {
      _menuList.clear();
    });
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
                children: const [Text('음식점을 입력해주세요')],
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('확인'))
              ],
            );
          });
      return;
    }
    setState(() {
      _menuList.add(menu);
      Navigator.pop(context);
    });
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
              child: const Text(
                '음식점 추가',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              margin: const EdgeInsets.all(10),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _addMenuController,
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () => _addMenu(_addMenuController.text),
                    child: const Text('추가하기')))
          ],
        ),
      ),
    );
  }
}
