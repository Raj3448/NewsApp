import 'package:flutter/material.dart';
import 'package:zapx/zapx.dart';

class ProfileWidget extends StatelessWidget {
const ProfileWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final screenSize = MediaQuery.of(context).size;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('profile')
        ],
      
    );
  }
}