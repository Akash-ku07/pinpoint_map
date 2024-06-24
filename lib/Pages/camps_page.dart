import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:hive_flutter/adapters.dart';

import '../model/data_model.dart';

class CampsPage extends StatefulWidget {
  @override
  _CampsPageState createState() => _CampsPageState();//creates an instance and manages the state of the campage
}

class _CampsPageState extends State<CampsPage> {
  Box<DataModel>? dataBox;
  List<DataModel> filteredCampsData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    openBox();
    searchController.addListener(_filterCamps);
  }

  Future<void> openBox() async {
    await Hive.initFlutter();
    dataBox = await Hive.openBox<DataModel>('dataBox');
    if (dataBox!.isEmpty) {
      await loadExcelData();
    }
    setState(() {
      filteredCampsData = dataBox!.values.toList();
    });
  }

  Future<void> loadExcelData() async {
    final ByteData data = await rootBundle.load('assets/camps_data.xlsx');
    final List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final Excel excel = Excel.decodeBytes(bytes);

    List<DataModel> tempList = [];
    for (var table in excel.tables.keys) {
      var sheet = excel.tables[table];
      for (var row in sheet!.rows.skip(1)) {
        tempList.add(DataModel(
          E: row[0]?.value?.toString() ?? '',
          N: row[1]?.value?.toString() ?? '',
          Street: row[2]?.value?.toString() ?? '',
          Camp: row[3]?.value?.toString() ?? '',
          Zone: row[4]?.value?.toString() ?? '',
          Country: row[5]?.value?.toString() ?? '',
          Makthab: row[6]?.value?.toString() ?? '',
          Category: row[7]?.value?.toString() ?? '',
        ));
      }
    }

    for (var dataModel in tempList) {
      await dataBox!.add(dataModel);
    }
  }

  void _filterCamps() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCampsData = dataBox!.values.where((camp) {
        return camp.Makthab.toLowerCase().contains(query) ||
            camp.Camp.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _onRowTap(BuildContext context, DataModel camp) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CampDetailsPage(camp: camp),
      ),
    );
  }

  @override
  void dispose() {
    searchController.removeListener(_filterCamps);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/hidayath_appbar.png"),
        leadingWidth: 100,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal[100],
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Camps Allotted',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Camps',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTableHeader('Maktab'),
                        _buildTableHeader('Camp'),
                        _buildTableHeader('Zone'),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: filteredCampsData.map((camp) {
                        return GestureDetector(
                          onTap: () => _onRowTap(context, camp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTableCell(camp.Makthab),
                              _buildTableCell(camp.Camp),
                              _buildZoneCell(camp.Zone),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String title) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(10.0),
      width: 100,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTableCell(String value) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: 100,
      child: Text(
        value,
      ),
    );
  }

  Widget _buildZoneCell(String value) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: 100,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: value == '2' ? Colors.orange : Colors.red,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CampDetailsPage extends StatelessWidget {
  final DataModel camp;

  CampDetailsPage({required this.camp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camp Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Maktab: ${camp.Makthab}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Camp: ${camp.Camp}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Zone: ${camp.Zone}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}