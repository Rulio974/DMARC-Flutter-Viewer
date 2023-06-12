import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> columns = [
  /// Text Column definition
  PlutoColumn(
    title: 'IP',
    field: 'ip_field',
    type: PlutoColumnType.text(),
  ),

  /// Number Column definition
  PlutoColumn(
    title: 'IPv6',
    field: 'ipv6_field',
    type: PlutoColumnType.text(),
  ),

  /// Select Column definition
  PlutoColumn(
    title: 'Rcount',
    field: 'rcount_field',
    type: PlutoColumnType.number(),
  ),

  /// Datetime Column definition
  PlutoColumn(
    title: 'dkim domain',
    field: 'dkim_field',
    type: PlutoColumnType.text(),
  ),

  /// Time Column definition
  PlutoColumn(
    title: 'spf domaine',
    field: 'spf_d_field',
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
    title: 'spf result',
    field: 'spf_r_field',
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
      title: 'spf align', field: 'spf_a_fiel', type: PlutoColumnType.text()),
  PlutoColumn(
      title: 'dkim align', field: 'dkim_a_fiel', type: PlutoColumnType.text()),
  PlutoColumn(
      title: 'identifier hfrom',
      field: 'id_h_fiel',
      type: PlutoColumnType.text()),

  // PlutoColumn(
  //   title: 'Treated',
  //   field: 'treated_field',
  //   type: PlutoColumnType.number(),
  //   enableRowChecked: true,  // Enable checkbox
  // ),
];
