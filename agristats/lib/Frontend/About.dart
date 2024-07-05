import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  final String _url = 'https://agrostats.jhubafrica.com/index.html';

  void _launchURL() async {
    final Uri url = Uri.parse(_url);
    await launchUrl(url);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
              fontSize: 18,
              // color: Colors.white,
              fontFamily: "Times"
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Learn more about us by visiting our website',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    // color: Colors.white,
                    fontFamily: "Times"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _launchURL,
                child: const Text(
                  'Visit our Website',
                  style: TextStyle(
                      fontSize: 16,
                      // color: Colors.white,
                      fontFamily: "Times"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}