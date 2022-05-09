import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_mail_app/open_mail_app.dart';

class SendEmail extends StatefulWidget {
  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Send WFH Email"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            const Text(
              'CEI America',
              style: TextStyle(fontSize: 10),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'WFH (${DateFormat('dd/MM/yyyy').format(now)})',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '[ ${DateFormat('EEEE').format(now)} ]',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                child: const Text('Send Mail'),
                onPressed: () async {
                  EmailContent email = EmailContent(
                      to: [
                        'rrafiq@ceiamerica.com',
                      ],
                      subject: 'WFH (${DateFormat('dd/MM').format(now)})',
                      body:
                          'Hi Rafiq,\n\nI am working from home today i.e. on ${DateFormat('dd/MM').format(now)} and will be available on listed channels.\n\nPhone: +91 9700887181\n\nMicrosoft Teams: https://teams.microsoft.com/l/chat/0/0?users=sbharadwaj@ceiamerica.com\n\nRegards,\nBharadwaj Saripalli',
                      cc: ['wfh.in@ceiamerica.com']);

                  OpenMailAppResult result =
                      await OpenMailApp.composeNewEmailInMailApp(
                          nativePickerTitle: 'Select Outlook',
                          emailContent: email);
                  if (!result.didOpen && !result.canOpen) {
                    showNoMailAppsDialog(context);
                  } else if (!result.didOpen && result.canOpen) {
                    showDialog(
                      context: context,
                      builder: (_) => MailAppPickerDialog(
                        mailApps: result.options,
                        emailContent: email,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
