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

Future<List<PlutoRow>> fetchData() async {
    final response = await http.get(Uri.parse("http://82.165.240.99:80"));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    
    return data.map((item) {
      return PlutoRow(
        cells: {
          'ip_field': PlutoCell(value: item['ip'].toString()),
          'ipv6_field': PlutoCell(value: item['ip6'] != null ? item['ip6'].toString() : 'NULL'),
          'rcount_field': PlutoCell(value: item['rcount'].toString()),
          'dkim_field': PlutoCell(value: item['dkimdomain']),
          'spf_d_field': PlutoCell(value: item['spfresult']),
          'spf_r_field': PlutoCell(value: item['spfresult']),
          'spf_a_fiel': PlutoCell(value: item['spf_align']),
          'dkim_a_fiel': PlutoCell(value: item['dkim_align']),
          'id_h_fiel': PlutoCell(value: item['identifier_hfrom']),
          // 'Treated' : PlutoCell(value: item['treated'])
        },
      );
    }).toList();
  } else {
    throw Exception('Failed to load data');
  }
}


@override
Widget build(BuildContext context) {
  return 

  FutureBuilder(

    future: fetchData(),
    builder: ((context, snapshot) {
      if(snapshot.hasData)
      {
        return PlutoGrid(columns: columns, rows: snapshot.data!,
        onRowDoubleTap:(event) {
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
                 title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this row?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                http.delete(Uri.parse('http://82.165.240.99:80/rptrecord/${event.row.cells['id_field']?.value}'))
                .then((http.Response response){
                  print('status code: ${response.statusCode}');
                  print('Body: ${response.body}');
                  Navigator.of(context).pop();
                  setState(() {});

                }).catchError((error) {
                  print('Error: $error');
                  // Handle error...
                  });
                
              
              },
            ),
          ],
              );
          
            }
          );
        },
        
        );

      }
      else if(snapshot.hasError)
      {
        return Text('${snapshot.error}');
      }
      return CircularProgressIndicator();
    }),
  );

}
}
