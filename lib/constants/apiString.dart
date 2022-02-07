class ApiString {
  static String getApiUrl(String month, String year) {
    return "https://api.aladhan.com/v1/calendar?latitude=23.777176&longitude=90.399452&method=2&&month=" +
        month +
        "&year=" +
        year +
        "";
  }
}
