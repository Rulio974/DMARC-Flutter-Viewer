import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const_var.dart';
import 'url_path_private.dart';

Future<int> fetchFileCount() async {
  final response = await http.get(url.resolve("/uploads/count"));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data['count'];
  } else {
    throw Exception('Failed to load file count');
  }
}

Future<List<PlutoRow>> fetchData() async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    List<PlutoRow> rows = data.map((item) {
      var ipAsNumber = int.tryParse(item['ip'].toString());
      var ipAddress = ipAsNumber != null ? _toIP(ipAsNumber) : "Invalid IP";

      return PlutoRow(
        cells: {
          'id_field': PlutoCell(value: item['id']),
          'ip_field': PlutoCell(value: ipAddress),
          'ipv6_field': PlutoCell(
              value: item['ip6'] != null ? item['ip6'].toString() : 'NULL'),
          'rcount_field': PlutoCell(value: item['rcount']),
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

    rows.sort((b, a) => a.cells['rcount_field']?.value
        .compareTo(b.cells['rcount_field']?.value));

    return rows;
  } else {
    throw Exception('Failed to load data');
  }
}

// Fonction pour convertir une valeur numérique en adresse IP standard
String _toIP(int ipAsNumber) {
  var bytes = ByteData(4)..setUint32(0, ipAsNumber, Endian.big);
  return '${bytes.getUint8(0)}.${bytes.getUint8(1)}.${bytes.getUint8(2)}.${bytes.getUint8(3)}';
}
