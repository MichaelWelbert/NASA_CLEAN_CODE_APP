class NasaEndpoints {
  static String apod(String apikey, String date) => "https://api.nasa.gov/planetary/apod?api_key=$apikey&date=$date";
}
