import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/get_icone.dart';

class ExpandedInfo extends StatelessWidget {
  final dynamic data;
  final List<dynamic> info;
  final Function onExit;

  const ExpandedInfo(
      {required this.data, required this.info, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onExit(),
      child: Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              // Ici
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: info.length,
                  itemBuilder: (context, index) {
                    var infoItem = data['info'][index];
                    return Container(
                      height: 50,
                      width: 100,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Text(
                            info[index]['title'] ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            info[index]['text'] ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
