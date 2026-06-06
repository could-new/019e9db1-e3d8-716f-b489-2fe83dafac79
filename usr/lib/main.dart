import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IQAC Activity Report',
      initialRoute: '/',
      routes: {
        '/': (context) => const ReportScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  Future<pw.Document> generateReport() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'Deccan Education Society’s',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'KIRTI M . DOONGURSEE COLLEGE (Autonomous)',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'Kashinath Dhuru Road, Dadar (W), Mumbai-400 028',
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    '(NAAC RE-ACCREDITED “A” GRADE)',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'INTERNAL QUALITY ASSURANCE CELL (IQAC)',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'Report of the Activity',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14, decoration: pw.TextDecoration.underline),
                  ),
                ),
                pw.SizedBox(height: 20),
                _buildRow('1. Name of the Department:', 'Red Ribbon Club / NSS Unit'),
                _buildRow('2. Title of the Activity:', 'Area Based Project 2 - Red Ribbon Club (Activities 1-17)'),
                _buildRow('3. NAAC Criteria /Key indicator:', 'N/A'),
                _buildRow('4. Date of the Activity:', 'Various (September 2025 - February 2026)'),
                _buildRow('5. Venue (Online platform or physical venue):', 'Various (College Campus, MDACS, Online, Shivansai Village)'),
                _buildRow('6. Objectives (2 to 3):', 'To create mass awareness about HIV/AIDS prevention and promote a healthy lifestyle. To develop peer educators and empower RRC leaders.'),
                _buildRow('7. Organizing Committee / Coordinators:', 'NSS Unit / Red Ribbon Club'),
                _buildRow('8. Resource Person / Speaker (If applicable):', 'MDACS Trainers'),
                _buildRow('9. Details of the activity(150-200 Words):', 'A comprehensive series of 17 activities were conducted under the Area Based Project 2 - Red Ribbon Club. These included peer educator training workshops, social media awareness campaigns, poster sticking, informative marathons, photo booth installations, reel making, human chains, street plays, and rangoli making competitions. The activities aimed at extensively educating volunteers, students, and the community at large regarding HIV/AIDS prevention. The campaign utilized both digital platforms and physical interactions to maximize reach and impact.'),
                _buildRow('10. Number of participants:', 'Multiple volunteers and beneficiaries across 17 activities'),
                _buildRow('11. Important Takeaways (Key learning outcomes):', 'Volunteers gained essential knowledge on HIV/AIDS prevention, understood the critical role of staying informed, and learned how to effectively disseminate awareness through visual messages, community engagement, and creative expression.'),
                _buildRow('12. Feedback Analysis (Attach summary):', 'Summary attached separately'),
                _buildRow('13. Follow up actions /Recommendations:', 'Continue continuous engagement programs and regular follow-up workshops.'),
                _buildRow('14. Summarize the Activity (Input-Process-Output-Impact):', 'Input: Training and resources. Process: 17 diverse awareness activities. Output: Widespread awareness among students and community. Impact: Enhanced knowledge and reduction of stigma around HIV/AIDS.'),
                _buildRow('15. Screenshots/photographs (should be integrated in the word document itself):', 'Attached below / as separate documents.'),
                _buildRow('16. Documents to be uploaded as proof:', 'Notice, Posters, Attendance Sheets.'),
                _buildRow('17. Attendance sheet:', 'Signed copies filed with NSS Unit.'),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildRow(String title, String content) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Text(content),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IQAC Report Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The report has been formatted according to the IQAC template\nand populated with the Red Ribbon Club activities data.', textAlign: TextAlign.center,),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('View / Download PDF Report'),
              onPressed: () async {
                final pdfDoc = await generateReport();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: const Text('PDF Preview')),
                      body: PdfPreview(
                        build: (format) => pdfDoc.save(),
                        canChangeOrientation: false,
                        canChangePageFormat: false,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
