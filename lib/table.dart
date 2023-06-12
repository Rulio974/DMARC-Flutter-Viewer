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
  return 
    Container(
      padding: const EdgeInsets.all(30),
      child: PlutoGrid(
          columns: columns,
          rows: rows,
          onChanged: (PlutoGridOnChangedEvent event) {
            print(event);
          },
          onLoaded: (PlutoGridOnLoadedEvent event) {
            print(event);
          }
      ),
    
  );
}
}
