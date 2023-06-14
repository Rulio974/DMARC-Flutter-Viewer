import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const_var.dart';

Future<List<PlutoRow>> fetchData() async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    return data.map((item) {
      return PlutoRow(
        cells: {
          'id_field': PlutoCell(value: item['id']),
          'ip_field': PlutoCell(value: item['ip'].toString()),
          'ipv6_field': PlutoCell(
              value: item['ip6'] != null ? item['ip6'].toString() : 'NULL'),
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
