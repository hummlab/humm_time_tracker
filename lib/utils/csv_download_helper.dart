import 'csv_download_helper_stub.dart' if (dart.library.html) 'csv_download_helper_web.dart' as impl;

Future<bool> downloadCsv({required String fileName, required String csvContent}) {
  return impl.downloadCsv(fileName: fileName, csvContent: csvContent);
}
