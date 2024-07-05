import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            // color: Colors.white,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Support', style: TextStyle(fontSize: 18, fontFamily: "Times")),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact us',
              style: TextStyle(
                fontFamily: "Times",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any enquiries, get in touch with us. We\'d be happy to help you.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Times",
              ),
            ),
            // SizedBox(height: 8),
            // Text(
            //   'We\'d be happy to help you.',
            //   style: TextStyle(
            //     fontFamily: "Times",
            //     fontSize: 16
            //   ),
            // ),
            SizedBox(height: 16),
            Text(
              'Reach out to us via email or phone number:',
              style: TextStyle(
                fontFamily: "Times",
                fontSize: 16
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Email: AgroStatsltd@gmail.com',
              style: TextStyle(
                fontFamily: "Times",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
