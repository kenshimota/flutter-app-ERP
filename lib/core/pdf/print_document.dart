import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<void> printDocument({required Widget Function(Context) build}) async {
  final doc = Document();

  doc.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      build: build,
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}
