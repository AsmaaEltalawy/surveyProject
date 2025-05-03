import 'package:dio/dio.dart';
import 'package:csv/csv.dart';
import 'package:surveypro/services/survey_model.dart';

class SurveyService {
  final Dio _dio = Dio();
  final url =
      'http://survey-pro-api.runasp.net/api/surveys/67d5d552b8036e3e24769144/responses/export';
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI2N2QzYzIyZDExMmM2NGJiMzUwYTA4MDEiLCJlbWFpbCI6ImFkbWluQHN1cnZleVByby5jb20iLCJ1bmlxdWVfbmFtZSI6ImFkbWluLTExMSIsInJvbGUiOiJhZG1pbiIsIm5iZiI6MTc0MzkxNzQ0MCwiZXhwIjoyMTAzOTE3NDQwLCJpYXQiOjE3NDM5MTc0NDAsImlzcyI6Ii9hcGkvYXV0aCIsImF1ZCI6Ii9hcGkvYXV0aCJ9.m0BSXT0YBXwM8Qz2_pgmy5tSak4W5r4cCX--5lgknAU';

  Future<List<SurveyModel>> fetchCsvData() async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final csvString = response.data.toString();
      final List<List<dynamic>> csvTable =
          const CsvToListConverter().convert(csvString);

      return csvTable
          .sublist(1)
          .map((row) {
            if (row == null || row.isEmpty) {
              return null;
            }
            return SurveyModel.fromList(row);
          })
          .where((item) => item != null)
          .cast<SurveyModel>()
          .toList();
    } catch (e) {
      throw Exception("an error occurred :$e");
    }
  }
}
