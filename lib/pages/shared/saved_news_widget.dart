import 'package:flutter/material.dart';

class SavedNewsWidget extends StatelessWidget {
const SavedNewsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final screenSize = MediaQuery.of(context).size;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('save')
        ],
      
    );
  }
}