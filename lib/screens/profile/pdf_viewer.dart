import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:real_estate/widget/appbar/first_appbar.dart';

import '../../utils/resizer/fetch_pixels.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(8),
              horizontal: FetchPixels.getPixelHeight(16),
            ),
            child: const FirstAppBar(title: ''),
          ),
          Expanded(
            child: const PDF().cachedFromUrl(
              'http://africau.edu/images/default/sample.pdf',
            ),
          ),
        ],
      ),
    );
  }
}
