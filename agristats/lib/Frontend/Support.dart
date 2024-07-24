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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Contact us',
              style: TextStyle(
                fontFamily: "Times",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'If you have any enquiries, get in touch with us. We\'d be happy to help you.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Times",
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Connect with us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Times",
                          fontSize: 15
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff255A6B),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
                            ),
                            onPressed: (){},
                            child: const Icon(
                              Icons.email,
                              size: 30,
                              color: Colors.white,
                            )
                        ),
                      ),
                      const SizedBox(width: 5,),
                      const Text(
                        'Or',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Times",
                            fontSize: 13
                        ),
                      ),
                      const SizedBox(width: 5,),
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff255A6B),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
                            ),
                            onPressed: (){},
                            child: const Image(
                              image: AssetImage("images/whatsapp.png"),
                              height: 30,
                              width: 30,
                            )
                        ),
                      )
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
