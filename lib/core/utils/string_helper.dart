class StringHelper {
  String extractFirstAndLastName(String fullName) {
    // Divide el nombre completo en partes
    List<String> nameParts = fullName.split(' ');
    if (nameParts.length == 2) {
      return fullName;
    }
    if (nameParts.length > 2) {
      return '${nameParts[0]} ${nameParts[2]}';
    }
    return fullName;
  }
}
