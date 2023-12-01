import 'package:flutter/material.dart';
import '../../../models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;

  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Card(
          color: Colors.black,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),

              //flag
              leading: Icon(data.icon.icon,
                  color: data.icon.color, size: data.icon.size ?? 28),

              //title
              title: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  data.title,
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              //subtitle
              subtitle: Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  data.subtitle,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          )),
    );
  }
}
