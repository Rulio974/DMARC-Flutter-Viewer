import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> columns = [
  /// Text Column definition
  PlutoColumn(
    title: 'IP',
    field: 'ip_field',
    type: PlutoColumnType.text(),
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),

  /// Number Column definition
  // PlutoColumn(
  //   title: 'IPv6',
  //   field: 'ipv6_field',
  //   type: PlutoColumnType.text(),
  // ),

  /// Select Column definition
  PlutoColumn(
    enableSorting: true,
    sort: PlutoColumnSort.descending,
    title: 'Rcount',
    field: 'rcount_field',
    type: PlutoColumnType.number(),
    width: 100,
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),

  /// Datetime Column definition
  PlutoColumn(
    title: 'dkim domain',
    field: 'dkim_field',
    type: PlutoColumnType.text(),
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),

  /// Time Column definition
  PlutoColumn(
    title: 'spf domaine',
    field: 'spf_d_field',
    type: PlutoColumnType.text(),
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),
  PlutoColumn(
    title: 'spf result',
    field: 'spf_r_field',
    type: PlutoColumnType.text(),
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),
  PlutoColumn(
    title: 'spf align',
    field: 'spf_a_fiel',
    type: PlutoColumnType.text(),
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),
  PlutoColumn(
    title: 'dkim align',
    field: 'dkim_a_fiel',
    type: PlutoColumnType.text(),
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),
  PlutoColumn(
    title: 'identifier hfrom',
    field: 'id_h_fiel',
    type: PlutoColumnType.text(),
    textAlign: PlutoColumnTextAlign.center,
    titleTextAlign: PlutoColumnTextAlign.center,
  ),

  // PlutoColumn(
  //   title: 'Treated',
  //   field: 'treated_field',
  //   type: PlutoColumnType.number(),
  //   enableRowChecked: true,  // Enable checkbox
  // ),
];
