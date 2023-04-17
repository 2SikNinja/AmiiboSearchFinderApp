import 'dart:async';
import 'package:flutter/material.dart';
import 'LoadingScreen.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Acceptance of Terms',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'By using this application, you are agreeing to be bound by these terms and conditions. If you do not agree with these terms, please do not use this application.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '2. Compliance with Applicable Laws',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You agree to comply with all applicable laws, regulations, and third-party rights when using this application. You will not use the application to promote illegal activities or violations of third-party rights.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '3. User Responsibilities',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You are responsible for ensuring that your use of this application complies with applicable laws, regulations, and third-party rights. You must not use this application in any way that could harm, disable, or impair the application or interfere with any other party\'s use and enjoyment of the application.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '5. Intellectual Property Rights',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'All intellectual property rights, including but not limited to copyrights, trademarks, and patents, in the application and its content are owned by or licensed to the developer, unless otherwise indicated. Unauthorized use, copying, or distribution of any intellectual property without the express written permission of the rights owner is prohibited.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '6. Limitation of Liability',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'To the extent permitted by law, the developer shall not be liable for any direct, indirect, incidental, special, consequential, or exemplary damages, including but not limited to damages for loss of profits, goodwill, use, data, or other intangible losses, resulting from the use or the inability to use the application.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '7. Indemnification',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You agree to indemnify, defend, and hold harmless the developer, its affiliates, officers, directors, employees, agents, licensors, and suppliers from and against all claims, losses, liabilities, expenses, damages, and costs, including reasonable attorneys\' fees, resulting from any violation of these terms and conditions or any activity related to your use of the application.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'By using this app, you agree to these terms and conditions.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
