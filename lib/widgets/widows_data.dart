import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_dev_com_dashboard/colors.dart';
import 'package:number_paginator/number_paginator.dart';

import '../charts_ui/models/DataModel.dart';

class WidowsData extends StatefulWidget {
  static const routeName = 'widowsData';
  const WidowsData({Key? key}) : super(key: key);

  @override
  State<WidowsData> createState() => _WidowsDataState();
}

class _WidowsDataState extends State<WidowsData> {
  late List _allData;
  late List _dataList;
  Future<dynamic> readJson({int page = 1, int maxResults = 9}) async {
    final int start = (page-1) * maxResults;
    final int end = start + maxResults;
    final String response = await rootBundle.loadString("assets/data.json");
    List<dynamic> values = await json.decode(response);
    _allData = values
        .map((e) => DataModel.fromJson(e as Map<String, dynamic>))
        .toList();
    _dataList = _allData
        .sublist(start, end);

  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Widows Data'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    itemCount: _dataList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemBuilder: (context, idx) {
                      print(_dataList[idx].fullName.toString().split(' '));
                      return WidowCard(dataModel: _dataList[idx]);
                    }),
              ),
              PaginationWidget(
                pageNumbers: _allData.length,
                onPageChange: (index){
                  print(index);
                  setState(() {
                    readJson(page: index+1);
                  });
                },
              )
            ],
          )),
    );
  }
}

class WidowCard extends StatelessWidget {
  final DataModel dataModel;
  const WidowCard({Key? key, required this.dataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRow('Name',
                      "${dataModel.fullName.toString().split(' ')[0]} ${dataModel.fullName.toString().split(' ')[1]}"),
                  buildRow('DOB', dataModel.dob?.substring(0, 10) ?? 'N/A'),
                  // buildRow('Address', dataModel.address.toString()),
                  buildRow('Phone', dataModel.phoneNumber.toString()),
                  buildRow('State', dataModel.state.toString()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View details',
                    style: TextStyle(fontSize: 10, color: kColor.dark),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 15,
                    color: kColor.dark,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildRow(String leftText, String rightText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: const TextStyle(fontSize: 8),
        ),
        Text(
          rightText,
          overflow: TextOverflow.clip,
          style: const TextStyle(fontSize: 8),
        )
      ],
    );
  }
}

class PaginationWidget extends StatefulWidget {
  final int pageNumbers;
  final Function(int index)? onPageChange;
  const PaginationWidget({Key? key, required this.pageNumbers, this.onPageChange}) : super(key: key);

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  @override
  Widget build(BuildContext context) {
    return NumberPaginator(
      onPageChange: widget.onPageChange,
        numberPages: widget.pageNumbers,
      config: NumberPaginatorUIConfig(
        buttonShape: const ContinuousRectangleBorder(),
        buttonSelectedBackgroundColor: kColor.dark,
        buttonSelectedForegroundColor: kColor.light,
        buttonUnselectedForegroundColor: Colors.black26,
        contentPadding: EdgeInsets.zero
      ),
    );
  }
}