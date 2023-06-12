import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'config/columns_config.dart';

class DmarcTable extends StatefulWidget {

  @override
  State<DmarcTable> createState() => _DmarcTableState();
}

class _DmarcTableState extends State<DmarcTable> {

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse("http://82.165.240.99:80"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

List<PlutoRow> rows = [
  PlutoRow(
    cells: {
      'ip_field': PlutoCell(value: '1406061475'),
      'ipv6_field': PlutoCell(value: 'NULL'),
      'rcount_field': PlutoCell(value: '6'),
      'dkim_field': PlutoCell(value: 'horoquartz.fr'),
      'spf_d_field': PlutoCell(value: 'pass'),
      'spf_r_field' : PlutoCell(value: 'pass'),
      'spf_a_fiel': PlutoCell(value: 'pass'),
      'dkim_a_fiel': PlutoCell(value: 'pass'),
      'id_h_fiel': PlutoCell(value: 'horoquartz.fr'),

    },
  ),
  
  
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['identifier_hfrom']),
                  // Add other fields as needed
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}